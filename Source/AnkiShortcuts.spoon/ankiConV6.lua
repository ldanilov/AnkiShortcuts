local json = require('json')

local ankiCon = {}
ankiCon.__index = ankiCon

ankiCon.serverUrl = 'http://localhost:8765'
ankiCon.version = 6
ankiCon.status = nil
ankiCon.body = nil
ankiCon.headers = nil
ankiCon.is_success = false
ankiCon.error = ''
ankiCon.result = ''

ankiCon.actions = {
    addOneNote = {
        dataFactory = function( question, answer, deck, tag )
            return json.encode({
                version = ankiCon.version,
                action = 'addNote',
                params = {
                    note = {
                        deckName = deck,
                        modelName = 'Basic', 
                        fields = {
                            Front = question,
                            Back = answer
                        },
                        tags = {tag}
                    }
                }
            })
        end,
        run = function( question, answer, deck, tag )
            ankiCon:handleResponse(
                hs.http.post(
                    ankiCon.serverUrl, 
                    ankiCon.actions.addOneNote.dataFactory( 
                        question, answer, deck, tag ), 
                    nil
                )
            )
        end,
    },
    addTwoNotes = {
        dataFactory = function( question, answer, deck, tag )
            return json.encode({
                version = ankiCon.version,
                action = 'addNotes',
                params = {
                    notes = {
                        {
                            deckName = deck,
                            modelName = 'Basic', 
                            fields = {
                                Front = question,
                                Back = answer
                            },
                            tags = {tag}
                        },{
                            deckName = deck,
                            modelName = 'Basic', 
                            fields = {
                                Front = answer,
                                Back = question
                            },
                            tags = {tag}
                        }
                    }
                }
            })
        end,
        run = function( question, answer, deck, tag )
            ankiCon:handleResponse(
                hs.http.post(
                    ankiCon.serverUrl, 
                    ankiCon.actions.addTwoNotes.dataFactory( 
                        question, answer, deck, tag ), 
                    nil
                )
            )
        end,
    },
    deckNames = {
        dataFactory = function()
            return json.encode({
                version = ankiCon.version,
                action = 'deckNames',
            })
        end,
        run = function()
            return ankiCon:handleResponse(
                hs.http.post(
                    ankiCon.serverUrl, 
                    ankiCon.actions.deckNames.dataFactory(), 
                    nil
                )
            )
        end,
    },
}

function ankiCon:handleResponse(status, body, headers)
    self.status = status
    self.body = json.decode(body)
    self.headers = headers
    if self.status == 200 and type(self.body.error) ~= 'string' then
        self.is_success = true
        self.result = self.body.result
    elseif type(self.body.error) == 'string' then
        self.is_success = false
        self.error = self.body.error
    end
end

function ankiCon:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return ankiCon