# Mylune's Champions

Mylune's Champions gives your companions, combat pets, and mounts personality-driven emotes. It can react when you or another player use a recognized emote, respond to events such as being AFK or entering combat, and produce occasional random emotes. Responses are sent as regular in-game emote chat.

Emote matching and interface text are available in English (`enUS`) and German (`deDE`).
If you want to add another locale, reach out and we will assist you!

## Install

You can download the Addon from
[WoWInterface](https://www.wowinterface.com/downloads/info27218-MylunesChampions.html) or
[Curseforge](https://www.curseforge.com/wow/addons/mylunes-champions).
Alternatively, you can install it manually:

1. Download and extract the addon so the `MylunesChampions` folder (containing `MylunesChampions.toc`) is inside your WoW Retail `Interface/AddOns` directory. For example:
   - Windows: `World of Warcraft\_retail_\Interface\AddOns\MylunesChampions\`
   - macOS: `World of Warcraft/_retail_/Interface/AddOns/MylunesChampions/`
2. Restart WoW and enable **Mylune's Champions** on the character-selection AddOns screen.
3. Open **Options → AddOns → Mylune's Champions** to configure the addon.

If you change the TOC or its file list while developing, fully restart WoW for the change to take effect; `/reload` alone does not reload TOC metadata.

## Use

The addon provides these chat commands:

| Command | Action |
| --- | --- |
| `/ce` | Ask your active companion to emote at random. |
| `/ce cheer` | Ask your companion to perform a supported standard emote. |
| `/ce <text>` | Send a one-time custom emote for your companion. |
| `/pe`, `/pe <emote>`, `/pe <text>` | The corresponding commands for your active combat pet. |
| `/mte`, `/mte <emote>`, `/mte <text>` | The corresponding commands for your active mount. |

Standard emote keys are locale-independent and only a subset is supported. Custom text is used as written. Automatic replies and random lines depend on the active champion and its personality settings.

## Configure

In the addon options, you can enable or disable the addon, choose the emote locale, adjust the automatic/random emote cooldowns, assign personalities to companions, combat pets, and mounts, and edit personality responses.

Personalities can inherit responses from another personality. Response text supports one alternative per line and these placeholders:

- `%t` — the target's name.
- `%s` — the name of the player whose emote prompted the response.

Clear a response field to use its inherited value. Enter `NA` to suppress an inherited response for that field. The options also provide an import from Chinchilla Critter Emote when that addon is installed and active; the import is enUS-only.

## For contributors

The addon is written in Lua and uses Ace3 libraries and LibBabble-CreatureType.
Dependencies are declared in [embeds.xml](embeds.xml) and [.pkgmeta](.pkgmeta); packaged releases obtain the declared library externals through the packager.
If you cloned this repository, you need to add the libraries yourself, e.g. by checking them out via SVN using the URLs provided in the .pkgmeta file.

No automated test suite is included. Lua or data changes should be verified in-game, ideally with Lua error reporting enabled. The addon is licensed under the GNU GPL v3; see [LICENSE](LICENSE).

### Adding support for a new locale

The addon distinguish between two locales: The game's locale (the language of WoW itself) and the emote locale (e.g., your custom emotes).
The files cover these as follows:
- `Locales/locale_*.lua`: These must match the game's locale.
- `Locales/general_*.lua`: These can be selected as emote locale (which may be different to the game's locale).
- `Data/personalities_*.lua`: These correspond also to the emote locale and contain the actual emote strings.

To add support for a new game locale, you need to copy `Locales/locale_enUS.lua` and provide the translations.
For the emote patterns (`L.EMOTE_PATTERNS`), you can use the Python script [tools/generate_emote_patterns.py](tools/generate_emote_patterns.py) (only available in the git repository, not provided in the release package):

1. Download the two CSV files for your locale from here:
   - https://wago.tools/db2/EmotesText
   - https://wago.tools/db2/EmotesTextData
2. Run the script (replace locale with the locale that you want to create):
   ```bash
   python3 tools/generate_emote_patterns.py --locale enUS \
        --emotes EmotesText.12.1.5.69848.csv \
        --data EmotesTextData.12.1.5.69848.csv
   ```

Now you should have the proper string patterns that are needed to detect incoming locales.
It will also add these strings to the `Locales/general_*.lua` file so the emote keys can be used as a shortcut (e.g., `/ce bye`)
