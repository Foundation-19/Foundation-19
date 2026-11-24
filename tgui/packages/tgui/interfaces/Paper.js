import { useBackend } from '../backend';
import { Box, Button } from '../components';
import { Window } from '../layouts';

const P = {
  bg: '#f5f1e3',
  text: '#1a1a1a',
  dim: '#6b6250',
  border: '#c9c0a8',
  accent: '#7a5c2e',
  warning: '#8a1c1c',
  font: '"Times New Roman", Times, Georgia, serif',
};

const findPaperLink = (target) => {
  while (target && target !== document.body) {
    if (target.getAttribute && target.getAttribute('data-paper-act')) {
      return target;
    }
    target = target.parentElement;
  }
  return null;
};

const handlePaperClick = (act, event) => {
  const link = findPaperLink(event.target);
  if (!link) {
    return;
  }
  event.preventDefault();
  if (link.getAttribute('data-paper-act') === 'write') {
    act('write', { field: link.getAttribute('data-paper-field') });
  }
};

export const Paper = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    content_html,
    info_links,
    stamps,
    language,
    has_content,
    editable,
    can_read,
    can_change_language,
    no_language,
    unknown_language,
    free_space,
    has_pen,
  } = data;

  return (
    <Window width={700} height={700} title={name || 'Paper'}>
      <Window.Content scrollable>
        <Box style={{
          background: P.bg,
          color: P.text,
          fontFamily: P.font,
          minHeight: '100%',
          padding: '24px 28px',
          border: '1px solid ' + P.border,
        }}>
          {!can_read ? (
            <Box mb={1} style={{ color: P.warning, fontStyle: 'italic' }}>
              The paper is too far away or you can't read.
            </Box>
          ) : null}

          {unknown_language ? (
            <Box mb={1} style={{ color: P.warning, fontStyle: 'italic' }}>
              The paper is written in a language you don't understand.
            </Box>
          ) : null}

          {!unknown_language && editable && has_content ? (
            <Box mb={1} style={{ color: P.dim, fontStyle: 'italic' }}>
              The paper is written in {language}.
            </Box>
          ) : null}

          {!unknown_language && editable && !has_content && can_change_language ? (
            <Box mb={1} style={{ color: P.dim, fontStyle: 'italic' }}>
              You are writing in{' '}
              <Button
                color="transparent"
                content={language}
                onClick={() => act('change_language')}
                style={{
                  color: P.accent,
                  fontFamily: P.font,
                  padding: 0,
                  background: 'transparent',
                  textDecoration: 'underline',
                }} />.
            </Box>
          ) : null}

          {no_language ? (
            <Box mb={1} style={{ color: P.warning, fontStyle: 'italic' }}>
              You can't write without knowing a language.
            </Box>
          ) : null}

          {!unknown_language && !editable && has_content ? (
            <Box mb={1} style={{ color: P.dim, fontStyle: 'italic' }}>
              The paper is written in {language}.
            </Box>
          ) : null}

          <Box mt={1} mb={2} style={{ borderTop: '1px solid ' + P.border }} />

          <Box
            onClick={(event) => handlePaperClick(act, event)}
            style={{ fontSize: '15px', lineHeight: '1.55', wordBreak: 'break-word' }}>
            <div dangerouslySetInnerHTML={{ __html: content_html || info_links || '' }} />
          </Box>

          {stamps ? (
            <Box
              mt={2}
              style={{ borderTop: '1px solid ' + P.border, paddingTop: '10px' }}
              dangerouslySetInnerHTML={{ __html: stamps }} />
          ) : null}

          {editable && !has_pen ? (
            <Box mt={2} style={{ color: P.dim, fontSize: '11px', fontStyle: 'italic' }}>
              You need a pen to write.
            </Box>
          ) : null}

          <Box mt={2} style={{ color: P.dim, fontSize: '11px' }}>
            {free_space} characters remaining
          </Box>
        </Box>
      </Window.Content>
    </Window>
  );
};
