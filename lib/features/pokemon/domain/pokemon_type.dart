/// Тип записи. В ответе PokéAPI он приходит строкой (`grass`), в модели это
/// значение перечисления: опечатку в нём поймает компилятор.
///
/// На моках хватало семи типов. С сервера приходят все восемнадцать.
enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
}
