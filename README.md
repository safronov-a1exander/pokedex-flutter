# Pokédex на Flutter

Шаблон курса кроссплатформенной разработки. Теги `w2-*` — каркас на моках с ПЗ2, тег `l3-network` — те же
экраны на данных из [PokéAPI](https://pokeapi.co/), пример к ЛР3.

Flutter 3.47.3, Dart 3.13.3, flutter_bloc 9.1.1, go_router 18.0.1, dio 5.11.1, json_serializable 6.14.1.

## Тег l3-network · сеть вместо моков

```bash
git switch -c my-l3 l3-network
flutter pub get
flutter run -d chrome
```

Что поменялось против `w2-end`: [сравнение на GitHub](https://github.com/safronov-a1exander/pokedex-flutter/compare/w2-end...l3-network).
Экраны остались прежними, к ним добавились загрузка, ошибка с «Повторить» и подгрузка страниц.

Цепочка: **API-клиент → датасорс → репозиторий → Cubit/Bloc → экран.**

| Файл | Что делает |
|---|---|
| `lib/common/network/dio_client.dart` | Создаёт Dio: базовый адрес, таймауты, лог запросов в debug |
| `lib/common/network/load_exception.dart` | Свои ошибки: нет сети, таймаут, 404, ошибка сервера, непонятный ответ |
| `features/pokemon/data/api/pokemon_api.dart` | API-клиент: один метод на один адрес, возвращает DTO |
| `features/pokemon/data/dto/` | DTO на `json_serializable`, рядом сгенерированные `.g.dart` |
| `features/pokemon/data/data_sources/` | Интерфейс датасорса и сетевая реализация: `DioException` превращается в `LoadException` |
| `features/pokemon/data/mappers/pokemon_mapper.dart` | DTO → модель приложения |
| `features/pokemon/data/pokemon_repository.dart` | Репозиторий на датасорсе. Запросы страницы и детали идут параллельно |
| `lib/app.dart` | Сборка цепочки: `PokemonRepository(NetworkPokemonDataSource(PokemonApi(DioClient.create())))` |

После правки DTO код генерируется заново:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Какие адреса PokéAPI зовёт приложение:

| Экран | Запросы |
|---|---|
| Список | `/pokemon?offset=N&limit=20`, потом 20 запросов `/pokemon/{имя}` параллельно: в странице нет типов и картинок |
| Деталь | `/pokemon/{id}` и `/pokemon-species/{id}` параллельно, потом `/evolution-chain/{n}` и записи цепочки |
| Поиск | Один раз `/pokemon?limit=<все>` за списком имён, дальше поиск в памяти и до 20 запросов `/pokemon/{имя}` |

Ответ `/pokemon/{id}` весит около 280 КБ, из них приложению нужны пара килобайт. В браузере этот JSON
разбирается в главном потоке.

Дальше в README описан каркас ПЗ2, он не изменился.

# Каркас на Flutter · ПЗ2

Это тот же покедекс, что на ПЗ1 был на Compose Multiplatform: те же двадцать записей и те же шаги, но на Flutter.

## До пары

Соберите шаблон заранее. Первый запуск скачивает пакеты и движок для браузера, на паре на это нет времени.

```bash
git clone https://github.com/safronov-a1exander/pokedex-flutter.git
cd pokedex-flutter
git switch -c feature/lab-2_frame w2-start
flutter run -d chrome
```

Если Chrome нет, запускайте `flutter run -d edge`. Команды одинаковые в PowerShell и bash.

Третья строка нужна обязательно. Без `switch -c` вы окажетесь в detached HEAD, и первый коммит не попадёт ни
в одну ветку.

Всё готово, если открылась вкладка «Покедекс» с фразой «В состоянии уже 20 записей».

## Запуск

```bash
flutter run -d chrome                           # браузер, на нём идёт пара (или -d edge)
flutter run -d chrome --dart-define=LOCALE=en   # английский интерфейс без смены языка браузера
flutter run -d chrome --no-web-resources-cdn    # если страница белая и не открывается gstatic.com
flutter run -d windows                          # desktop, нужна Visual Studio с C++
```

На паре работаем в браузере, он есть у всех. Для desktop на Windows нужна Visual Studio с workload «Desktop
development with C++», для Android нужны SDK и эмулятор. Это ставится дома, если выбрали такой второй таргет.

В терминале `flutter run`: `r` применяет правку и сохраняет состояние (hot reload), `R` перезапускает приложение
с нуля (hot restart), `q` выход.

На тегах `w2-*` картинки, данные и шрифт лежат в репозитории, и приложение работает без сети. На `l3-network`
данные и картинки приходят с сервера. Флаг `--no-web-resources-cdn` отдаёт движок отрисовки локально.

## Шаги и догон

Каждый шаг пары отмечен тегом: `w2-start`, `w2-cp1` … `w2-cp5`, `w2-end`. Если отстали, сохраните свою работу
и возьмите ветку от тега нужного шага.

PowerShell (в Windows PowerShell 5.1 нет `&&`):

```powershell
git add -A; git commit -m wip
git switch -c catchup-cp3 w2-cp3
```

bash:

```bash
git add -A && git commit -m wip
git switch -c catchup-cp3 w2-cp3
```

Ваша работа остаётся в вашей ветке, вернуться к ней: `git switch feature/lab-2_frame`.

## Что должно получиться

Шаг считается сделанным, когда на экране видно то, что в правой колонке.

| # | Что делаю | Что вижу |
|---|---|---|
| 1 | Прокручиваю список | 20 карточек: номер, имя, картинка на фоне цвета типа, бейджи типов |
| 2 | Открываю карточку, на детали открываю соседа по эволюции, потом дважды «назад» стрелкой или кнопкой браузера | Адрес `/#/pokemon/1`, потом `/#/pokemon/3`. «Назад» возвращает по одному экрану: venusaur, bulbasaur, список |
| 2a | Открываю `/#/pokemon/4` в новой вкладке, потом меняю в адресе 4 на 7 | Сразу деталь Charmander. После правки Squirtle, а не прошлая запись |
| 3 | Переключаю тему | Темнеют фон, шапка и карточки. Подписи читаются, бейджи типов цвет не меняют |
| 4 | `dart run tool/check_arb.dart`, потом `flutter run -d chrome --dart-define=LOCALE=en` | «en: 0 расхождений». Интерфейс, вкладка и типы на английском, данные те же |
| 5 | Печатаю `saur`, открываю деталь, возвращаюсь, жму крестик в поле | Остаются три записи, запрос на месте, поле и список очищаются вместе |

## Как устроен проект

Код разложен по фичам. Всё, что относится к покедексу, лежит в `lib/features/pokemon`, общее для всех экранов
лежит в `lib/common`.

| Папка | Что там |
|---|---|
| `features/pokemon/domain` | Модель записи и интерфейс репозитория. Без Flutter |
| `features/pokemon/data` | Моки и репозиторий, который их отдаёт |
| `features/pokemon/presentation/bloc` | Cubit списка и Bloc детали с их состояниями |
| `features/pokemon/presentation/view` | Экраны и виджеты. Получают модель как есть |
| `features/pokemon/presentation/utils` | Расширения для показа: имя с заглавной, номер 001, рост в метрах, цвет и подпись типа |
| `common/theme` | Цвета, пути к картинкам, тема |
| `common/navigation` | Адреса экранов и go_router |
| `common/widgets` | Шапка и кнопка темы |

Зависимости собираются в `lib/app.dart`. Репозиторий кладётся в дерево через `RepositoryProvider` по интерфейсу,
Cubit и Bloc получают его через `context.read<IPokemonRepository>()`.

## Что лежит в стартовом состоянии

| Путь | Что это |
|---|---|
| `lib/features/pokemon/domain/pokemon_model.dart` | Модель записи. Поля названы как в ответе PokéAPI, позже сюда подключим сеть |
| `lib/features/pokemon/domain/pokemon_type.dart` | Тип записи, `enum` из семи значений |
| `lib/features/pokemon/data/mock_pokemons.dart` | 20 записей из PokéAPI. Единственное место с данными каталога |
| `lib/features/pokemon/presentation/bloc/list/` | Состояние списка и Cubit. Cubit пока берёт моки напрямую |
| `lib/features/pokemon/presentation/view/pokemon_list_screen.dart` | Стартовый экран с числом записей в состоянии |
| `lib/features/pokemon/presentation/view/widgets/` | Готовые куски карточки: фон, картинка, бейдж и строка типов, полоса характеристики |
| `lib/features/pokemon/presentation/utils/` | Расширения для показа записи, типа и характеристики |
| `lib/common/theme/` | `AppColors` (опорный цвет и цвета типов) и `ImageSources` (пути к картинкам) |
| `lib/common/widgets/app_scaffold.dart` | Шапка приложения |
| `lib/app.dart` | Корень приложения: локализация, Cubit и стартовый экран |
| `assets/sprites/` | 20 картинок, лежат локально |
| `assets/fonts/` | Шрифт Roboto из Flutter SDK (Apache 2.0), без него браузер идёт за шрифтом в сеть |
| `lib/l10n/app_ru.arb`, `app_en.arb` | Подписи интерфейса на двух языках, код к ним генерирует gen_l10n |
| `tool/check_arb.dart` | Сверяет ключи и параметры в двух языках. Нужен на шаге 4 |

Репозиторий, список, деталь, навигацию, тему и подписи пишем на паре.

## Правила

**Подписи только в ARB.** Всё, что видит пользователь, лежит в `lib/l10n/*.arb`, включая заголовок вкладки.
Совпадение ключей проверяет скрипт:

```bash
dart run tool/check_arb.dart      # код возврата 1, если в одном языке ключа нет
```

После добавления ключа в ARB выполните `flutter gen-l10n` или `flutter pub get`, иначе анализатор не увидит
новый ключ. Если ключ забыт во втором языке, gen_l10n не выдаст ошибку, а подставит текст из русского файла.
Это ловит только скрипт.

Подписи прямо в виджетах скрипт не находит. Их ищем так:

```bash
git grep -nE "Text\(\s*'" -- lib
```

Пустой вывод значит, что всё в порядке. `Text(pokemon.displayName)` поиск не находит, и это правильно: данные
не переводятся.

**Данные на английском.** В PokéAPI нет русского языка. Переводим интерфейс, а не данные каталога.

**Экраны получают модель.** Отдельных классов «для экрана» нет. Как показать запись, решают расширения в
`presentation/utils`: `pokemon.displayName`, `pokemon.displayNumber`, `type.color`, `type.label(l10n)`.

**Навигация через go_router.** Маршрут здесь строка с путём, поэтому адресная строка браузера работает сразу.
Пути собраны в `AppRoutes`, переход делает сам виджет: `context.push(AppRoutes.detail(id))`.
В Compose Multiplatform маршрут объект, это главное отличие стеков на этом шаге.

## Cubit и Bloc

Список сделан на Cubit (`PokemonListCubit`), деталь на Bloc (`PokemonDetailBloc`). Принцип один: состояние
идёт вниз в экран, действия пользователя идут вверх, состояние меняет только Cubit или Bloc. Разница в том,
как действие попадает внутрь.

| | Список, Cubit | Деталь, Bloc |
|---|---|---|
| Как экран сообщает о действии | Вызывает публичный метод: `load()`, `search('saur')` | Передаёт событие: `add(PokemonDetailOpened(4))` |
| Где разбирается | В теле метода | В обработчике, зарегистрированном в конструкторе: `on<PokemonDetailOpened>(...)` |
| Состояние | Один класс `PokemonListState` с `copyWith` | `sealed`-класс с вариантами `PokemonDetailLoading`, `PokemonDetailLoaded`, `PokemonDetailNotFound` |
| Где создаётся | В `app.dart`, один на всё приложение | В экране детали, свой у каждой открытой записи |
| Экран закрыли, пока ждали ответ | Проверяем `isClosed` сами | Обработчик отменяется вместе с Bloc |
| Когда брать | Действий мало, порядок не важен | Событий много, важны порядок и отмена |

Ни Cubit, ни Bloc не знают про виджеты и навигацию. В ЛР2 подходят оба способа.

## Откуда данные и картинки

На `l3-network` всё приходит из PokéAPI. На тегах `w2-*` записи и картинки взяты из CMP-шаблона ПЗ1 (`composeResources/drawable`), туда они загружены из
[PokéAPI](https://pokeapi.co/). Покемоны являются торговой маркой Nintendo и Game Freak, используются в учебных целях.
