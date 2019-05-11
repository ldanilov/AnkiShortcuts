--- === AnkiShortcuts ===
---
--- AnkiShortcuts was built to help you speed up the process of adding Question/Answer notes to your [Anki](https://apps.ankiweb.net) deck on OSX. It uses [AnkiConnect plug-in](https://ankiweb.net/shared/info/2055492159) which hosts a small local webserver and allows AnkiShortcuts to interact with Anki app via REST API. 
---
--- Download: [https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip](https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip)
---
--- ### AnkiShortcuts Spoon Demo
--- ![AnkiShortcuts Spoon Demo](https://github.com/ldanilov/AnkiShortcuts/raw/master/AnkiShortcutsDemo.gif)
---
--- ### AnkiShortcuts lets you:
--- - **Send new Question/Answer** cards with simple shortcuts:
---    - `[Ctrl, Opt, Cmd] + [`
---       - **Save** current cursor selection as a **Question**.
---    - `[Ctrl, Opt, Cmd] + ]`
---       1. **Save** current cursor selection as an **Answer**
---       2. **Send** it as a new Note to Anki.
---    - `[Ctrl, Opt, Cmd] + \`
---       1. Does the same as **]**
---       2. But instead of one card, it sends **two** cards, flipping Question in place of the Answer.
---    - `[Ctrl, Opt, Cmd] + =`
---       1. Does the same as **]**
---       2. But before sending the card to Anki, it lets you edit the Answer. Albeit in a too small of a text field for convenient editing for now.
--- - `[Ctrl, Opt, Cmd] + D`
---    1. **Get** all Deck Names from your Anki app.
---    2. **Select** one of them to use going forward.
--- - `[Ctrl, Opt, Cmd] + T`
---    - **Set a Tag** value to be used on all new Notes going forward.
--- - `[Ctrl, Opt, Cmd] + X`
---    - **Set a Context** value to be used on all new Notes going forward.
---       - This text is added underneath each Question, as an unordered list.
---       - Adding a Context and adding Title of a Window to Context are both Enabled by default. 
---          - You may disable by setting `addContext` or `addWinTitleToContext` to `false`.
---
--- ## Getting Started
--- ### Prerequisites
--- - macOS High Sierra 
---    - works on v10.13.6
--- - Anki v2.1
---    - https://apps.ankiweb.net/index.html#mac
--- - Hammerspoon v0.9
---    - https://github.com/Hammerspoon/hammerspoon/releases/tag/0.9.71
--- - AnkiConnect v6
---    - https://ankiweb.net/shared/info/2055492159
---
--- ### Installing
--- 1. Install Prerequisites
--- 2. Install AnkiShortcuts Spoon from [https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip](https://github.com/ldanilov/AnkiShortcuts/raw/master/Spoons/AnkiShortcuts.spoon.zip)
--- 3. Configure shortcuts by adding the following to your `~/.hammerspoon/init.lua`
---    ```
---    local hyper = {"ctrl", "alt", "cmd"}
---    spoon.AnkiShortcuts:bindHotkeys(
---      {
---        setDeck = {hyper, "D"},
---        setTag = {hyper, "T"},
---        setQuestion = {hyper, "["},
---        setAnswerSend1Note = {hyper, "]"},
---        editAnswerSend1Note = {hyper, "="},
---        setAnswerSend2Notes = {hyper, "\\"},
---        toggleListener = {hyper, "N"},
---        setContext = {hyper, "X"},
---      }
---    )
---    ```
--- 4. **(optional)** Set Configurable values in your `~/.hammerspoon/init.lua`  
---    - `spoon.AnkiShortcuts.addContext` (Default `true`)
---    - `spoon.AnkiShortcuts.addWinTitleToContext` (Default `true`)
---    - `spoon.AnkiShortcuts.deckName` (Default `""`)
---    - See more in API Overview
---
--- ### Running
--- 1. Choose a Deck to use via shortcut `setDeck`.
--- 2. **(optional)** Choose a Tag to use via shortcut `setTag` (Default `""`)
--- 3. Steps to send your first Note to Anki:
---    - Select a chunk of text somewhere (from Browser, PDF file, etc.).
---       - ex: "`Anki is a program which makes remembering things easy.`"
---    - Press shortcut `setQuestion`. This will be your Question.
---    - Select a chunk of text somewhere (from Browser, PDF file, etc.).
---       - ex: "`remembering`"
---    - Press shortcut `setAnswerSend1Note`. 
---       - This will be your Answer
---       - It will be sent to Anki right away.
---       - An alert will pop up saying that a Note was added.
---    - A note was added:
---       - **Question**
---       ```
---       Anki is a program which makes ___________ things easy. 
---
---       Context:
---         - Anki - powerful, intelligent flashcards - Google Chrome
---       ```
---       - **Answer**
---       ```
---       remembering
---       ```
---
--- ### Building
--- - Each build needs to generate a new `docs.json` and `README.md` files. Follow these steps:
---   - Clone https://github.com/Hamerspoon/hammerspoon
---   - Install the required Python dependencies (e.g. pip install --user -r requirements.txt in the Hammerspoon repo)
---   - Specify `HAMMERSPOON_REPO` variable in `env.make` (see env.make.example)
--- - Run `make` after any updates to Source/* files. It regenerates `README.md`, `docs.json`, and `Spoons/AnkiShortcuts.spoon.zip`
---
--- ### Known Issues
--- - Does not check if Anki app is running, so in that case Hammerspoon Console returns an obscure error.
--- - It takes a few seconds to send the **first** Note to Anki. Subsequent Notes are sent in under a second.
---    - (edit) On the second thought, the delay occurs **not** only during the first Note add. It varries a little, so be patient with it. :)
---    - TODO: troubleshoot this
---
--- ### Ideas
--- - (easy) Add color to successful/unsuccessful addition of Q/A.
--- - (easy) Start Anki if the app is not running.
--- - (hard) Find a way to capture a LaTeX from PDF (or otherwise) and add it as MathJax.
--- - (easy) Add some menu so user doen't need to reply on shortcuts for everything.
--- - (medium) Allow user define their own Q/A template (i.e. where to put Context and other info)
--- - (easy) Lookup existing Tags in current Deck; let user choose one of them.
---
--- ### Other Notes
--- - For more info about benefits of using a tool like Anki, check out [Michael Nielsen's post "Augmenting Long-term Memory"](http://augmentingcognition.com/ltm.html).
--- - Known issues may or may not get fixed depending on how annoying they get for me.
--- - Besides making a useful tool, this project proved a good reason to learn Lua. However, if something doesn't work out for you because I missed something, sorry about that. Feel free to clone, tweak, and submit a pull request.

local json = require('json')

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AnkiShortcuts"
obj.version = "0.1"
obj.author = "Lev Danilov"
obj.homepage = "https://github.com/ldanilov/AnkiShortcuts"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    obj.question = ''
    obj.answer = ''
    obj.winTitle = ''
    obj.currentDecks = {}
    obj.tag = ''
    obj.listener = nil
    obj.userContext = ''
end

local getSetting = function(label, default) 
    return hs.settings.get(obj.name.."."..label) or default 
end

local setSetting = function(label, value)
    hs.settings.set(obj.name.."."..label, value)
    return value 
end

--- AnkiShortcuts.deckName
--- Variable
--- Deck name we should use at start-up. (Default: '')
obj.deckName = getSetting('deckName', '')

--- AnkiShortcuts.addWinTitleToContext
--- Variable
--- Toggle whether you want to add a Title of the Window
--- in which you are selecting Question/Answer to 
--- the bottom of each Question. (Default: true)
obj.addWinTitleToContext = getSetting('addWinTitleToContext', true)

--- AnkiShortcuts.addContext
--- Variable
--- Toggle whether you want to add any Context to 
--- the bottom of each Question. (Default: true)
obj.addContext = getSetting('addContext', true)

--- AnkiShortcuts.ankiConUrl
--- Variable
--- URL of the AnkiConnect Plug-in server. (Default: 'http://localhost:8765')
obj.ankiConUrl = getSetting('ankiConUrl', 'http://localhost:8765')

--- AnkiShortcuts.ankiConVersion
--- Variable
--- Version of the AnkiConnect Plug-in from https://github.com/FooSoft/anki-connect
--- (Default: 6)
obj.ankiConVersion = getSetting('ankiConVersion', 6)

-- Internal Function used to find our location, so we know where to load files from
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end
obj.spoonPath = script_path()

local ankiCon = dofile(
    obj.spoonPath .. "ankiConV" .. obj.ankiConVersion .. '.lua'
)

-- Internal Function - get any string of text which is selected by cursor.
function _cursor_selection()
    local priorSelection=hs.pasteboard.getContents()
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(20000)
    local selection = hs.pasteboard.getContents()
    local windowTitle = hs.window.focusedWindow():title()
    if selection == "" then
        hs.alert.show('Error: please, select some text.')
    else
        return selection, windowTitle
    end
 end

-- Internal Function - remove whitespaces from both ends of a string.
--
-- Parameters:
--  * string.
-- Returns:
--  * trimmed string.
function _all_trim(s)
    if s ~= nil then
        return s:match( "^%s*(.-)%s*$" )
    else
        return s
    end
end

-- Internal Function - replaces any instances of "answer" with "_" in a question.
--
-- Parameters:
--  * question - a question sting.
--     * (example in) Donald Knuth is often quoted about optimisation: "If you optimise everything, you will always be unhappy" 
--  * answer - an answer string.
--     * (example in) If you optimise everything, you will always be unhappy
--
-- Returns:
--  * question - a question sting with answer instances blanked out.
--     * (example out) Donald Knuth is often quoted about optimisation: "__ ___ ________ ___________ ___ ____ ______ __ _______"
--  * answer - an unchanged answer string.
--     * (example out) If you optimise everything, you will always be unhappy
function _mask_answer(question, answer)
    local q_lower = string.lower( question )
    local a_lower = string.lower( _all_trim( answer ) )
    while true do
        if e ~= nil then e = e + 1 end
        local s, e = string.find( q_lower, a_lower, e )
        if s == nil then break end
        local replacement = string.sub( question, s, e ) 
        replacement = string.gsub( replacement, '[^%s]' , '_' )
        question = string.sub( question, 0, s-1 ) 
                    ..replacement 
                    ..string.sub( question, e+1, string.len( question ) )
        q_lower = string.lower( question )
        if q_lower == nil then break end
    end
    return question, answer
end

-- Internal Function - replaces all characters code point > 127 to HTML enities.
--
-- Parameters:
--  * s - string which may contain unicode chars above 127
--
-- Returns:
--  * out - same string with any unicode chars over code 127 converted to HTML entities.
function _unicode2html(s)
    if type(s) ~= 'string' then return '' end
    local out = ''
    for pos, c in utf8.codes(s) do 
        if c > 127 then
            out = out .. '&#' .. c .. ';'
        else
            out = out .. utf8.char(c)
        end
    end
    return out
end

-- Internal Function - discards all non-ascii non-characters from a string.
--
-- Parameters:
--  * s - string which may contain unicode chars above 126 and below 32.
--
-- Returns:
--  * out - same string with any unicode chars over code 126 and under 32 discarded.
function _unicode2ascii(s)
    if type(s) ~= 'string' then return '' end
    local out = ''
    for pos, c in utf8.codes(s) do 
        if c < 127 and c > 31 then
            out = out .. utf8.char(c)
        end
    end
    return out
end

-- AnkiShortcuts:setCurrentDecks()
-- Internal Method
-- Gets a list of Anki Decks in alphabetical order and saves into currentDecks array.
function obj:setCurrentDecks()
    local anki = ankiCon:new()
    anki.actions.deckNames.run()
    if anki.is_success then
        table.sort(
            anki.result, 
            function(a, b) return a:upper() < b:upper() end)
        self.currentDecks = anki.result
    elseif anki.status ~= 200 then
        hs.alert.show(
            'Error connecting to anki webserver at ' 
              .. anki.serverUrl,
            7
        )
    else
        hs.alert.show(anki.error)
    end
end

-- AnkiShortcuts:sendNoteToAnki(how)
-- Internal Method
-- Sends one Note to Anki with question and answer.
--
-- Parameters:
--  * how - which schema to use
--     * "QA" will add one note -- Question/Answer
--     * "QAAQ" will add two notes -- Question/Answer and Answer/Question.
--
-- Returns:
--  * None
function obj:sendNoteToAnki(how)
    self.question = _unicode2html(self.question)
    self.answer = _unicode2html(self.answer)
    self.tag = _unicode2ascii(self.tag)
    local context = _unicode2html(self:getContext())

    self.question, self.answer = _mask_answer(self.question, self.answer)
    local anki = ankiCon:new()
    if how == 'QAAQ' then
        anki.actions.addOneNote.run(
            self.question .. context, 
            self.answer, 
            self.deckName, 
            self.tag
        )
        anki.actions.addOneNote.run(
            self.answer .. context, 
            self.question, 
            self.deckName, 
            self.tag
        )
    else
        anki.actions.addOneNote.run(
            self.question .. context, 
            self.answer, 
            self.deckName, 
            self.tag
        )
    end
    if anki.is_success then
        hs.alert.show('Note Added', 1)
    elseif type(anki.error) == 'string' then
        hs.alert.show(anki.error)
    else
        hs.alert.show(
            'ERROR connecting to anki webserver at: ' 
              .. anki.serverUrl,
            7
        )
    end
end

function obj:handleNoise(noise)
    local noiseTypes = {
        sssStart = 1,
        sssStop  = 2,
        lipPop   = 3
    }
    if noise == noiseTypes.sssStart then
        self.question, self.winTitle = _cursor_selection()
        hs.alert.show("Question", 0.5)
    elseif noise == noiseTypes.lipPop then
        hs.alert.show("Answer", 0.5)
        hs.alert.show("Sent", 0.5)
        self.answer, self.winTitle = _cursor_selection()
        self:sendNoteToAnki("QA")
    end
end

function obj:toggleListener()
    if self.listener ~= nil then
        self.listener:stop()
        self.listener = nil
        hs.alert.show("Listening Stopped", 1)
    else
        self.listener = hs.noises.new(
            function(param) self:handleNoise(param) end
        ):start()
        hs.alert.show("Listening Started", 1)
    end
end

function obj:setDeck()
    self:setCurrentDecks()
    local choices = {}
    for i = 1, #self.currentDecks do
        local deck = { 
            text = self.currentDecks[i] 
        }
        table.insert( choices,  deck )
    end
    local deckChoices = hs.chooser.new(function(param) 
        if param == nil then
            hs.alert.show(
                'Deck Remains: ' .. json.encode(self.deckName),
                1
            )
        else
            self.deckName = param['text']
            hs.alert.show(
                'Deck Selected: ' .. json.encode(self.deckName),
                1
            )
        end
    end)
    local deckChoices = deckChoices:choices(choices)
    local deckChoices = deckChoices:show()
end


function obj:setTag()
    local button, value = hs.dialog.textPrompt(
        'tag Name (current tag is: "' .. self.tag .. '")', 
        'This tag will be saved with anki notes and ' ..
        'will persist between sends. Update it each ' ..
        'time you want to change the tag.', 
        "", 
        "Save", 
        "Cancel"
    )
    if button == "Cancel" then 
        hs.alert.show(
            'Tag Remains: ' .. json.encode(self.tag),
            1
        )
    else
        self.tag = value
        hs.alert.show(
            'Tag Selected: ' .. json.encode(self.tag),
            1
        )
    end
end

function obj:getContext()
    local function notEmpty(s) return s ~= nil and s ~= '' end
    local ctxt = '</br></br>Context:' 
                 .. '<ul style="font-weight: bold;">'
    local contextExists = false
    if notEmpty(self.userContext) then
        ctxt = ctxt .. '<li>' .. self.userContext .. '</li>'
        contextExists = true
    end
    if obj.addWinTitleToContext and notEmpty(self.winTitle) then
        ctxt = ctxt .. '<li>' .. self.winTitle .. '</li>'
        contextExists = true
    end
    ctxt = ctxt .. '</ul>'
    if obj.addContext and contextExists then
        return ctxt
    else
        return ''
    end
end

function obj:setQuestion()
    self.question, self.winTitle = _cursor_selection()
end

function obj:setAnswerSend1Note()
    self.answer, self.winTitle = _cursor_selection()
    self:sendNoteToAnki("QA")
end

function obj:editAnswerSend1Note()
    self.answer, self.winTitle = _cursor_selection()
    local button, value = hs.dialog.textPrompt(
        'Answer', 
        '', 
        self.answer, 
        'Send to Anki', 
        'Cancel'
    )
    if button == 'Cancel' then 
        hs.alert.show('Canceled', 1)
    else
        self.answer = value
        self:sendNoteToAnki('QA')
    end
end

function obj:setAnswerSend2Notes()
    self.answer, self.winTitle = _cursor_selection()
    self:sendNoteToAnki("QAAQ")
end

function obj:setContext()
    local button, value = hs.dialog.textPrompt(
        'Context (current Context is: "' .. self.userContext .. '")', 
        'Will be added to the  bottom of each question card. ' .. 
        'It helps during recall.', 
        "", 
        "Save", 
        "Cancel"
    )
    if button == "Cancel" then 
        hs.alert.show(
            'Context Remains: ' .. json.encode(self.userContext),
            1
        )
    else
        self.userContext = value
        hs.alert.show(
            'Context Selected: ' .. json.encode(self.userContext),
            1
        )
    end
end

--- AnkiShortcuts:bindHotkeys()
--- Method
--- Binds hotkeys for Anki Shortcuts.
---
--- Parameters:
---  * mapping - A table containing hotkey details for the following items:
---   * setDeck - for choosing a Deck from current Anki list (usually {hyper, "D"})
---   * setTag - for setting a tag (e.g. {hyper, "T"})
---   * setQuestion - for saving selected text as a question (usually {hyper, "["})
---   * setAnswerSend1Note - for saving selected answer and sending 1 Note to Anki (Q->A) (usually {hyper, "]"})
---   * setAnswerSend2Notes - for saving selected answer and sending 2 Notes to Anki (Q->A and A->Q) (usually {hyper, "\"})
---
--- A configuration example can be:
--- ```
--- local hyper = {"ctrl", "alt", "cmd"}
--- spoon.AnkiShortcuts:bindHotkeys({
---   setDeck = {hyper, "D"},
---   setTag = {hyper, "T"},
---   setQuestion = {hyper, "["},
---   setAnswerSend1Note = {hyper, "]"},
---   setAnswerSend2Notes = {hyper, "\"}
--- })
--- ```
function obj:bindHotkeys(m)
    hs.inspect(m)
    print("Bind Hotkeys for Anki Shortcuts")
    -- CHOOSE a DECK from all current Anki Decks.
    hs.hotkey.bind(
        m.setDeck[1], 
        m.setDeck[2], 
        function() self:setDeck() end
    )
    -- SET a TAG.
    hs.hotkey.bind(
        m.setTag[1], 
        m.setTag[2], 
        function() self:setTag() end
    )
    -- SAVE cursor selection into ANSWER variable.
    hs.hotkey.bind(
        m.setQuestion[1],
        m.setQuestion[2], 
        function() self:setQuestion() end
    )
    -- SAVE cursor selection into ANSWER variable.
    -- and
    -- SEND one Note to Anki with QUESTION, Answer.
    hs.hotkey.bind(
        m.setAnswerSend1Note[1], 
        m.setAnswerSend1Note[2], 
        function() self:setAnswerSend1Note() end
    )
    -- EDIT cursor selection into ANSWER variable.
    -- and
    -- SEND one Note to Anki.
    hs.hotkey.bind(
        m.editAnswerSend1Note[1], 
        m.editAnswerSend1Note[2], 
        function() self:editAnswerSend1Note() end
    )
    -- SAVE current selection into ANSWER variable.
    -- and
    -- SEND two Notes to Anki with (1) Q -> A (2) A -> Q.
    hs.hotkey.bind(
        m.setAnswerSend2Notes[1], 
        m.setAnswerSend2Notes[2], 
        function() self:setAnswerSend2Notes() end
    )
    -- TOGGLE hs.noises listener ON / OFF
    hs.hotkey.bind(
        m.toggleListener[1], 
        m.toggleListener[2], 
        function() self:toggleListener() end
    )
    -- SET Context
    hs.hotkey.bind(
        m.setContext[1], 
        m.setContext[2], 
        function() self:setContext() end
    )
end

return obj