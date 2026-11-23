import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const HumanAppearance = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    specimen,
    gender,
    change_skin_tone,
    change_skin_color,
    change_eye_color,
    change_hair_color,
    change_facial_hair_color,
    change_race,
    species,
    change_gender,
    genders,
    change_hair,
    hair_styles,
    hair_style,
    change_facial_hair,
    facial_hair_styles,
    facial_hair_style,
    change_languages,
    languages,
  } = data;
  return (
    <Window width={800} height={450}>
      <Window.Content scrollable>
        <Section title="Appearance Editor">
          <LabeledList>
            <LabeledList.Item label="Species">
              {specimen}
              {!!change_race && species && species.map((race, i) => (
                <Button key={i} ml={1} onClick={() => act('race', { race: race.specimen })}>
                  {race.specimen}
                </Button>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Gender">
              {gender}
              {!!change_gender && genders && genders.map((g, i) => (
                <Button key={i} ml={1} selected={g.gender_key === gender} onClick={() => act('gender', { gender: g.gender_key })}>
                  {g.gender_name}
                </Button>
              ))}
            </LabeledList.Item>
            {!!change_skin_tone && (
              <LabeledList.Item label="Skin Tone">
                <Button onClick={() => act('skin_tone')}>Change Skin Tone</Button>
              </LabeledList.Item>
            )}
            {!!change_skin_color && (
              <LabeledList.Item label="Skin Color">
                <Button onClick={() => act('skin_color')}>Change Skin Color</Button>
              </LabeledList.Item>
            )}
            {!!change_eye_color && (
              <LabeledList.Item label="Eye Color">
                <Button onClick={() => act('eye_color')}>Change Eye Color</Button>
              </LabeledList.Item>
            )}
            {!!change_hair && hair_styles && (
              <LabeledList.Item label="Hair Style">
                {hair_style}
                {hair_styles.map((h, i) => (
                  <Button key={i} ml={1} selected={h.hairstyle === hair_style} onClick={() => act('hair', { hair: h.hairstyle })}>
                    {h.hairstyle}
                  </Button>
                ))}
              </LabeledList.Item>
            )}
            {!!change_hair_color && (
              <LabeledList.Item label="Hair Color">
                <Button onClick={() => act('hair_color')}>Change Hair Color</Button>
              </LabeledList.Item>
            )}
            {!!change_facial_hair && facial_hair_styles && (
              <LabeledList.Item label="Facial Hair">
                {facial_hair_style}
                {facial_hair_styles.map((f, i) => (
                  <Button key={i} ml={1} selected={f.facialhairstyle === facial_hair_style} onClick={() => act('facial_hair', { facial_hair: f.facialhairstyle })}>
                    {f.facialhairstyle}
                  </Button>
                ))}
              </LabeledList.Item>
            )}
            {!!change_facial_hair_color && (
              <LabeledList.Item label="Facial Hair Color">
                <Button onClick={() => act('facial_hair_color')}>Change Color</Button>
              </LabeledList.Item>
            )}
            {!!change_languages && languages && (
              <LabeledList.Item label="Languages">
                {languages.map((l, i) => (
                  <Button key={i} ml={1} selected={l.selected} onClick={() => act('language', { language: l.language, language_mode: l.selected ? "remove" : "add" })}>
                    {l.language}
                  </Button>
                ))}
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
