# [Hammerspoon](#hammerspoon) » AnkiShortcuts
---

AnkiShortcuts was built to help you speed up the process of adding Question/Answer notes to your [Anki](https://apps.ankiweb.net) deck on OSX. It uses [AnkiConnect plug-in](https://ankiweb.net/shared/info/2055492159) which hosts a small local webserver and allows AnkiShortcuts to interact with Anki app via REST API. 

Download: [https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip](https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip)

### AnkiShortcuts Spoon Demo
![AnkiShortcuts Spoon Demo](https://github.com/ldanilov/AnkiShortcuts/raw/master/AnkiShortcutsDemo.gif)

### AnkiShortcuts lets you:
- **Send new Question/Answer** cards with simple shortcuts:
   - `[Ctrl, Opt, Cmd] + [`
      - **Save** current cursor selection as a **Question**.
   - `[Ctrl, Opt, Cmd] + ]`
      1. **Save** current cursor selection as an **Answer**
      2. **Send** it as a new Note to Anki.
   - `[Ctrl, Opt, Cmd] + \`
      1. Does the same as **]**
      2. But instead of one card, it sends **two** cards, flipping Question in place of the Answer.
   - `[Ctrl, Opt, Cmd] + =`
      1. Does the same as **]**
      2. But before sending the card to Anki, it lets you edit the Answer. Albeit in a too small of a text field for convenient editing for now.
- `[Ctrl, Opt, Cmd] + D`
   1. **Get** all Deck Names from your Anki app.
   2. **Select** one of them to use going forward.
- `[Ctrl, Opt, Cmd] + T`
   - **Set a Tag** value to be used on all new Notes going forward.
- `[Ctrl, Opt, Cmd] + X`
   - **Set a Context** value to be used on all new Notes going forward.
      - This text is added underneath each Question, as an unordered list.
      - Adding a Context and adding Title of a Window to Context are both Enabled by default. 
         - You may disable by setting `addContext` or `addWinTitleToContext` to `false`.

## Getting Started
### Prerequisites
- macOS
   - High Sierra
   - Mojave
- Anki v2.1
   - https://apps.ankiweb.net/index.html#mac
   - AnkiConnect v6 (Anki Add-on)
      - Install using the following add-on code: `2055492159`
      - Add-on Info: https://ankiweb.net/shared/info/2055492159
- Hammerspoon v0.9
   - https://github.com/Hammerspoon/hammerspoon/releases

### Installing
1. Install Prerequisites
2. Install AnkiShortcuts Spoon from [https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip](https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip)
3. Configure shortcuts by adding the following to your `~/.hammerspoon/init.lua`
   ```
   local hyper = {"ctrl", "alt", "cmd"}
   spoon.AnkiShortcuts:bindHotkeys(
     {
       setDeck = {hyper, "D"},
       setTag = {hyper, "T"},
       setQuestion = {hyper, "["},
       setAnswerSend1Note = {hyper, "]"},
       editAnswerSend1Note = {hyper, "="},
       setAnswerSend2Notes = {hyper, "\\"},
       toggleListener = {hyper, "N"},
       setContext = {hyper, "X"},
     }
   )
   ```
4. **(optional)** Set Configurable values in your `~/.hammerspoon/init.lua`  
   - `spoon.AnkiShortcuts.addContext` (Default `true`)
   - `spoon.AnkiShortcuts.addWinTitleToContext` (Default `true`)
   - `spoon.AnkiShortcuts.deckName` (Default `""`)
   - See more in API Overview

### Running
1. Choose a Deck to use via shortcut `setDeck`.
2. **(optional)** Choose a Tag to use via shortcut `setTag` (Default `""`)
3. Steps to send your first Note to Anki:
   - Select a chunk of text somewhere (from Browser, PDF file, etc.).
      - ex: "`Anki is a program which makes remembering things easy.`"
   - Press shortcut `setQuestion`. This will be your Question.
   - Select a chunk of text somewhere (from Browser, PDF file, etc.).
      - ex: "`remembering`"
   - Press shortcut `setAnswerSend1Note`. 
      - This will be your Answer
      - It will be sent to Anki right away.
      - An alert will pop up saying that a Note was added.
   - A note was added:
      - **Question**
      ```
      Anki is a program which makes ___________ things easy. 

      Context:
        - Anki - powerful, intelligent flashcards - Google Chrome
      ```
      - **Answer**
      ```
      remembering
      ```

### Building
- Each build needs to generate a new `docs.json` and `README.md` files. Follow these steps:
  - Clone https://github.com/Hamerspoon/hammerspoon
  - Install the required Python dependencies (e.g. pip install --user -r requirements.txt in the Hammerspoon repo)
  - Specify `HAMMERSPOON_REPO` variable in `env.make` (see env.make.example)
- Run `make` after any updates to Source/* files. It regenerates `README.md`, `docs.json`, and `Spoons/AnkiShortcuts.spoon.zip`

### Known Issues
- Does not check if Anki app is running, so in that case Hammerspoon Console returns an obscure error.
- It takes a few seconds to send the **first** Note to Anki. Subsequent Notes are sent in under a second.
   - (edit) On the second thought, the delay occurs **not** only during the first Note add. It varries a little, so be patient with it. :)
   - TODO: troubleshoot this

### Ideas
- (easy) Add color to successful/unsuccessful addition of Q/A.
- (easy) Start Anki if the app is not running.
- (hard) Find a way to capture a LaTeX from PDF (or otherwise) and add it as MathJax.
- (easy) Add some menu so user doen't need to reply on shortcuts for everything.
- (medium) Allow user define their own Q/A template (i.e. where to put Context and other info)
- (easy) Lookup existing Tags in current Deck; let user choose one of them.

### Other Notes
- For more info about benefits of using a tool like Anki, check out [Michael Nielsen's post "Augmenting Long-term Memory"](http://augmentingcognition.com/ltm.html).
- Known issues may or may not get fixed depending on how annoying they get for me.
- Besides making a useful tool, this project proved a good reason to learn Lua. However, if something doesn't work out for you because I missed something, sorry about that. Feel free to clone, tweak, and submit a pull request.

## API Overview
* Variables - Configurable values
 * [addContext](#addContext)
 * [addWinTitleToContext](#addWinTitleToContext)
 * [ankiConUrl](#ankiConUrl)
 * [ankiConVersion](#ankiConVersion)
 * [deckName](#deckName)
* Methods - API calls which can only be made on an object returned by a constructor
 * [bindHotkeys](#bindHotkeys)

## API Documentation

### Variables

| [addContext](#addContext)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts.addContext`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Toggle whether you want to add any Context to                                                                      |

| [addWinTitleToContext](#addWinTitleToContext)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts.addWinTitleToContext`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Toggle whether you want to add a Title of the Window                                                                     |

| [ankiConUrl](#ankiConUrl)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts.ankiConUrl`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | URL of the AnkiConnect Plug-in server. (Default: 'http://localhost:8765')                                                                     |

| [ankiConVersion](#ankiConVersion)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts.ankiConVersion`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Version of the AnkiConnect Plug-in from https://github.com/FooSoft/anki-connect                                                                     |

| [deckName](#deckName)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts.deckName`                                                                    |
| **Type**                                    | Variable                                                                     |
| **Description**                             | Deck name we should use at start-up. (Default: '')                                                                     |

### Methods

| [bindHotkeys](#bindHotkeys)         |                                                                                     |
| --------------------------------------------|-------------------------------------------------------------------------------------|
| **Signature**                               | `AnkiShortcuts:bindHotkeys()`                                                                    |
| **Type**                                    | Method                                                                     |
| **Description**                             | Binds hotkeys for Anki Shortcuts.                                                                     |
| **Parameters**                              | <ul><li>mapping - A table containing hotkey details for the following items:</li><li> setDeck - for choosing a Deck from current Anki list (usually {hyper, "D"})</li><li> setTag - for setting a tag (e.g. {hyper, "T"})</li><li> setQuestion - for saving selected text as a question (usually {hyper, "["})</li><li> setAnswerSend1Note - for saving selected answer and sending 1 Note to Anki (Q->A) (usually {hyper, "]"})</li><li> setAnswerSend2Notes - for saving selected answer and sending 2 Notes to Anki (Q->A and A->Q) (usually {hyper, "\"})</li></ul> |

# Hammerspoon
---

## Project Links
| Resource        | Link                             |
| --------------- | -------------------------------- |
| Website | [http://www.hammerspoon.org/](http://www.hammerspoon.org/) |
| GitHub page | [https://github.com/Hammerspoon/hammerspoon](https://github.com/Hammerspoon/hammerspoon) |
| Getting Started Guide | [http://www.hammerspoon.org/go/](http://www.hammerspoon.org/go/) |
| Spoon Plugin Documentation | [https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md) |
| Official Spoon repository | [http://www.hammerspoon.org/Spoons](http://www.hammerspoon.org/Spoons) |
| IRC channel | [irc://chat.freenode.net/#hammerspoon](irc://chat.freenode.net/#hammerspoon) |
| Mailing list | [https://groups.google.com/forum/#!forum/hammerspoon/](https://groups.google.com/forum/#!forum/hammerspoon/) |
| LuaSkin API docs | [http://www.hammerspoon.org/docs/LuaSkin/](http://www.hammerspoon.org/docs/LuaSkin/) |
