/**
 * Browser-agnostic abstraction of key-value web storage.
 *
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const IMPL_MEMORY = 0;
export const IMPL_HUB_STORAGE = 1;
export const IMPL_INDEXED_DB = 2;
export const IMPL_IFRAME_INDEXED_DB = 3;

const INDEXED_DB_VERSION = 1;
const INDEXED_DB_NAME = 'tgui';
const INDEXED_DB_STORE_NAME = 'storage-v1';

const READ_ONLY = 'readonly';
const READ_WRITE = 'readwrite';

// How long to wait for a reply from the storage iframe before giving up.
// A dead/missing iframe must not leave requests (and their waiters) hanging.
const IFRAME_REQUEST_TIMEOUT = 5000;
// The ping is intentionally short: it is used to detect whether the
// iframe backend works at all, so we can fall back quickly.
const IFRAME_PING_TIMEOUT = 100;

const testGeneric = (testFn) => () => {
  try {
    return Boolean(testFn());
  } catch {
    return false;
  }
};

const testHubStorage = testGeneric(
  () => window.hubStorage && window.hubStorage.getItem
);

// TODO: Remove with 516
// prettier-ignore
const testIndexedDb = testGeneric(() => (
  (window.indexedDB || window.msIndexedDB)
  && (window.IDBTransaction || window.msIDBTransaction)
));

class MemoryBackend {
  constructor() {
    this.impl = IMPL_MEMORY;
    this.store = {};
  }

  async get(key) {
    return this.store[key];
  }

  async set(key, value) {
    this.store[key] = value;
  }

  async remove(key) {
    this.store[key] = undefined;
  }

  async clear() {
    this.store = {};
  }
}

class HubStorageBackend {
  constructor() {
    this.impl = IMPL_HUB_STORAGE;
  }

  async get(key) {
    const value = await window.hubStorage.getItem('f19-' + key);
    if (typeof value === 'string') {
      return JSON.parse(value);
    }
  }

  async set(key, value) {
    window.hubStorage.setItem('f19-' + key, JSON.stringify(value));
  }

  async remove(key) {
    window.hubStorage.removeItem('f19-' + key);
  }

  async clear() {
    window.hubStorage.clear();
  }
}

class IFrameIndexedDbBackend {
  constructor() {
    this.impl = IMPL_IFRAME_INDEXED_DB;
    /** Requests waiting for a reply. Each entry owns its timeout. */
    this.waiters = [];
  }

  async ready() {
    const iframe = document.createElement('iframe');
    iframe.style.display = 'none';
    iframe.src = Byond.storageCdn;

    const completePromise = new Promise((resolve) => {
      iframe.onload = () => resolve(this);
    });

    this.documentElement = document.body.appendChild(iframe);
    this.iframeWindow = this.documentElement.contentWindow;

    // A SINGLE message listener for the whole lifetime of the backend.
    // Previous implementation installed a fresh (never-removed) listener
    // for every get()/ping()/getChatMessages() call, which piled up
    // listeners and caused every reply to be delivered N times.
    this.handleMessageEvent = (messageEvent) => {
      if (this.iframeWindow && messageEvent.source !== this.iframeWindow) {
        return;
      }
      const data = messageEvent.data;
      // Resolve every waiter that matches this reply.
      for (let i = this.waiters.length - 1; i >= 0; i--) {
        const waiter = this.waiters[i];
        if (waiter.match(data)) {
          this.waiters.splice(i, 1);
          clearTimeout(waiter.timer);
          waiter.resolve(data);
        }
      }
    };
    window.addEventListener('message', this.handleMessageEvent);

    return completePromise;
  }

  /**
   * Registers a waiter for the next matching reply and sends the request.
   * `fallback` is resolved if no reply arrives within the timeout.
   */
  request(match, timeout, fallback, requestPayload) {
    const promise = new Promise((resolve) => {
      const waiter = {
        match,
        resolve,
        timer: setTimeout(() => {
          const index = this.waiters.indexOf(waiter);
          if (index >= 0) {
            this.waiters.splice(index, 1);
          }
          resolve(fallback);
        }, timeout),
      };
      this.waiters.push(waiter);
    });
    this.iframeWindow.postMessage(requestPayload, '*');
    return promise;
  }

  async get(key) {
    const data = await this.request(
      (reply) => reply.key === key,
      IFRAME_REQUEST_TIMEOUT,
      undefined,
      { type: 'get', key: key }
    );
    return data && data.value;
  }

  async set(key, value) {
    this.iframeWindow.postMessage({ type: 'set', key: key, value: value }, '*');
  }

  async remove(key) {
    this.iframeWindow.postMessage({ type: 'remove', key: key }, '*');
  }

  async clear() {
    this.iframeWindow.postMessage({ type: 'clear' }, '*');
  }

  async ping() {
    const data = await this.request(
      (reply) => reply === true,
      IFRAME_PING_TIMEOUT,
      undefined,
      { type: 'ping' }
    );
    return data === true;
  }

  async processChatMessages(messages) {
    this.iframeWindow.postMessage(
      { type: 'processChatMessages', messages: messages },
      '*'
    );
  }

  async getChatMessages() {
    const data = await this.request(
      (reply) => reply.messages !== undefined,
      IFRAME_REQUEST_TIMEOUT,
      undefined,
      { type: 'getChatMessages' }
    );
    return data && data.messages;
  }

  async setNumberStored(number) {
    this.iframeWindow.postMessage(
      { type: 'setNumberStored', newMax: number },
      '*'
    );
  }

  async destroy() {
    if (this.handleMessageEvent) {
      window.removeEventListener('message', this.handleMessageEvent);
      this.handleMessageEvent = null;
    }
    // Drop any pending waiters so they do not fire later.
    for (let waiter of this.waiters) {
      clearTimeout(waiter.timer);
    }
    this.waiters = [];
    if (this.documentElement) {
      document.body.removeChild(this.documentElement);
    }
    this.documentElement = null;
    this.iframeWindow = null;
  }
}

class IndexedDbBackend {
  // TODO: Remove with 516
  constructor() {
    this.impl = IMPL_INDEXED_DB;
    /** @type {Promise<IDBDatabase>} */
    this.dbPromise = new Promise((resolve, reject) => {
      const indexedDB = window.indexedDB || window.msIndexedDB;
      const req = indexedDB.open(INDEXED_DB_NAME, INDEXED_DB_VERSION);
      req.onupgradeneeded = () => {
        try {
          req.result.createObjectStore(INDEXED_DB_STORE_NAME);
        } catch (err) {
          reject(new Error('Failed to upgrade IDB: ' + req.error));
        }
      };
      req.onsuccess = () => resolve(req.result);
      req.onerror = () => {
        reject(new Error('Failed to open IDB: ' + req.error));
      };
    });
  }

  async getStore(mode) {
    // prettier-ignore
    return this.dbPromise.then((db) => db
      .transaction(INDEXED_DB_STORE_NAME, mode)
      .objectStore(INDEXED_DB_STORE_NAME));
  }

  async get(key) {
    const store = await this.getStore(READ_ONLY);
    return new Promise((resolve, reject) => {
      const req = store.get(key);
      req.onsuccess = () => resolve(req.result);
      req.onerror = () => reject(req.error);
    });
  }

  async set(key, value) {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.put(value, key);
  }

  async remove(key) {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.delete(key);
  }

  async clear() {
    // NOTE: We deliberately make this operation transactionless
    const store = await this.getStore(READ_WRITE);
    store.clear();
  }
}

/**
 * Web Storage Proxy object, which selects the best backend available
 * depending on the environment.
 */
export class StorageProxy {
  constructor() {
    this.backendPromise = (async () => {
      if (!Byond.TRIDENT) {
        if (Byond.storageCdn) {
          const iframe = new IFrameIndexedDbBackend();
          await iframe.ready();

          if ((await iframe.ping()) === true) {
            return iframe;
          }

          iframe.destroy();
        }

        if (!testHubStorage()) {
          Byond.winset(null, 'browser-options', '+byondstorage');

          return new Promise((resolve) => {
            const listener = () => {
              document.removeEventListener('byondstorageupdated', listener);
              resolve(new HubStorageBackend());
            };

            document.addEventListener('byondstorageupdated', listener);
          });
        }
        return new HubStorageBackend();
      }
      // TODO: Remove with 516
      if (testIndexedDb()) {
        try {
          const backend = new IndexedDbBackend();
          await backend.dbPromise;
          return backend;
        } catch {}
      }
      console.warn(
        'No supported storage backend found. Using in-memory storage.'
      );
      return new MemoryBackend();
    })();
  }

  async get(key) {
    const backend = await this.backendPromise;
    return backend.get(key);
  }

  async set(key, value) {
    const backend = await this.backendPromise;
    return backend.set(key, value);
  }

  async remove(key) {
    const backend = await this.backendPromise;
    return backend.remove(key);
  }

  async clear() {
    const backend = await this.backendPromise;
    return backend.clear();
  }
}

export const storage = new StorageProxy();
