# PZBS-owskie australijskie butlery

Wrapper dla [jfrteamy-ausbutler](https://github.com/emkael/jfrteamy-ausbutler), ustawiający generowanie znormalizowanych butlerów dla lig centralnych PZBS.

Poniższe README nie porusza tematów konfiguracji `jfrteamy-ausbutler`, a wyłącznie spięcie go do automatycznego generowania butlerów dla lig centralnych.

## Pliki wykonywalne

Projekt zawiera dwa pliki wykonywalne:

 * `ausbutler-single.sh IDENTYFIKATOR_TURNIEJU`, generujący i wysyłający pojedynczy turniej
 * `ausbutler-all.sh`, iterujący po wszystkich turniejach w `tournaments.txt`

## Lista turniejów

Plik `tournaments.txt` definiuje, dla jakich konfiguracji (turniejów) generowane będą butlery. Po jednym identyfikatorze na wiersz.

Dla każdego identyfikatora, w katalogu `configs` musi być zdefiniowany zestaw zmiennych konfiguracyjnych (patrz niżej).

## Szablon konfiguracji

Katalog `config.template` zawiera szablon kompletu plików konfiguracyjnych, które `jfrteamy-ausbutler` czytają z podkatalogu `config` katalogu roboczego.

Każdy z plików szablonów może zawierać zmienne w formacie jak dla powłoki Bash, pod które podstawiane są wartości z odpowiedniego pliku w katalogu `configs`.

Na szablon składa się komplet plików JSON dla `jfrteamy-ausbutler` oraz, opcjonalnie, plik `send.lftp` formatu skryptu narzędzia `lftp`, jeśli chcemy również od razu wysyłać wygenerowane pliki przez FTP.

## Konfiguracja

Konfiguracja generowana jest następująco:

1. Do lokalnego środowiska uruchomieniowego importowana jest (poprzez Bashowe `source` z opcją auto-eksportu zmiennych) zawartość plików: `configs/_common.env` oraz `configs/IDENTYFIKATOR_TURNIEJU.env` (w takiej kolejności).

2. Tak ustawione zmienne środowiskowe kompilowane są do szablonów z `config.template`, a następnie zapisywane do katalogu `config`.

3. Uruchamiany jest `jfrteamy-ausbutler`, z konfiguracją zdefiniowaną poprzez skompilowany zestaw plików `config/*.json`.

4. Jeśli w systemie obecne jest narzędzie `lftp`, uruchamiane jest z żądaniem wykonania skryptu skompilowanego do `config/send.lftp`.

## Zmienne konfiguracyjne

`LIGA_AUSBUTLER_DB_HOST`, `LIGA_AUSBUTLER_DB_USER`, `LIGA_AUSBUTLER_DB_PASS`, `LIGA_AUSBUTLER_DB_NAME` - paramatery MySQL (host, użytkownik, hasło, nazwa bazy danych turnieju)

`LIGA_AUSBUTLER_OUTPUT_PATH` - katalog wyjściowy dla plików z wynikami

`LIGA_AUSBUTLER_FTP_HOST`, `LIGA_AUSBUTLER_FTP_USER`, `LIGA_AUSBUTLER_FTP_PASS`, `LIGA_AUSBUTLER_FTP_PATH` - parametry FTP (host, użytkownik, hasło, ścieżka na zdlanym serwerze)

Przykładowa konfiguracja znajduje się w plikach `configs/*.env.sample`.
