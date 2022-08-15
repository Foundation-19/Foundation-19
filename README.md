### <p align="center"><img src=".github/assets/f19.png" width="200"> 
<p align="center">Secure. Contain. Protect.

# Foundation-19
### Добро пожаловать в репозиторий русского форка **Foundation-19**, основанного на [BayStation 12](https://github.com/Baystation12/Baystation12), перебазированом на [TeguStation](https://github.com/vlggms/tegustation).

[![forthebadge](https://forthebadge.com/images/badges/built-with-resentment.svg)](#) [![forthebadge](https://forthebadge.com/images/badges/contains-tasty-spaghetti-code.svg)](#) [![forinfinityandbyond](https://user-images.githubusercontent.com/5211576/29499758-4efff304-85e6-11e7-8267-62919c3688a9.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

## Комьюнити
[<img src=".github/assets/discord.png" alt="Discord" width="150" align="left">](https://discord.gg/cZz6mNt)
**Discord-сервер** проекта является нашей основной площадкой для общения и связи с игроками. Там вы сможете получать все необходмые новости касательно проекта, вести открытое общение с другими игроками, а также иметь доступ ко множеству различных полезных каналов.

**Space Station 13** это многопользовательская компьютерная игра о работе и жизни персонала на космической станции с элементами выживания. Игра разработана независимым разработчиком Exadv1 на игровом движке «BYOND», имеет тайловую 2D графику и доступна на платформах Windows. Данная сборка основана на вселенной SCP, где действия игры разворачиваются в **Site 53**.

## :exclamation: Инструкция по компиляции :exclamation:

**Быстрый способ**. Найти `bin/server.cmd` по указанному пути и запустить его двойным кликом, для автоматической компиляции и создания сервера с портом 1337.

**Долгий способ**. Найти `bin/build.cmd` по указанному пути и запустить его двойным кликом для начала компиляции. Она состоит из нескольких шагов и может занять в районе 1-5 минут времени. Как только окно закроется, компиляцию можно считать завершённой. После этого, вы можете запустить свой локальный сервер при помощи DreamDaemon, выбрав файл `baystation12.dmb` лежащий в корневой папки сборки.

**Компиляция baystation12.dmb напрямую через DreamMaker не рекомендуется и может вызвать ошибки**, такие как `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**

## Contributing
[Guidelines for Contributors](.github/CONTRIBUTING.md)

[Code of Conduct](docs/CODE_OF_CONDUCT.md)

## LICENSE
[![license-badge](https://www.gnu.org/graphics/agplv3-155x51.png)](https://www.gnu.org/licenses/agpl-3.0.html)

Code with a git authorship date prior to `1420675200 +0000` (2015/01/08 00:00 GMT) is licensed under the GNU General Public License version 3, which can be found in full in [/docs/GPL3.txt](/docs/GPL3.txt)

All code where the authorship dates on or after `1420675200 +0000` is assumed to be licensed under AGPL v3, if you wish to license under GPL v3 please make this clear in the commit message and any added files.

The TGS DMAPI API is licensed as a subproject under the MIT license.

See the footer of code/__DEFINES/tgs.dm and code/modules/tgs/LICENSE for the MIT license.

If you wish to develop and host this codebase in a closed source manner you may use all commits prior to `1420675200 +0000`, which are licensed under GPL v3.  The major change here is that if you host a server using any code licensed under AGPLv3 you are required to provide full source code for your servers users as well including addons and modifications you have made.

See [here](https://www.gnu.org/licenses/why-affero-gpl.html) for more information.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
