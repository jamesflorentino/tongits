#=============================================
# Global vars and CONSTANTS
#=============================================
HOST = 'localhost'
PORT = 7000
net = require 'net'
sys = require 'util'
_ = require './underscore'

Data =
  rooms: []

#=============================================
# UTILITIES
#=============================================
randomId = (len=8) ->
  chars = 'abcdefghijklmnopqrstuvwxyz1234567890'
  id = ''
  while id.length < len
    index = Math.random() * chars.length
    id += chars.substr index, 1
  id


#=============================================
# CLASSES
#=============================================
class Model
  constructor: (@attributes) ->
    @id = randomId()
    @initialize @attributes
  initialize: ->
    return
  
  get: (prop) ->
    @attributes[prop]

  set: (props) ->
    for key of props
      @attributes[key] = props[key]
    this


class Room extends Model
  initialize: ->
    return

class User extends Model
  initialize: ->
    return

#=============================================
# API
#=============================================



#=============================================
# Listeners
#=============================================
server = net.createServer (stream) ->

  ServerAPI =

    createRoom: (roomName) ->
      room = new Room name: roomName
      Data.rooms.push room
      console.log "room <#{room.id}> : #{room.get('name')}"
      return

    addUser: (userName, roomId) ->
      user = new User name: userName
      return

    readData: (data) ->
      command = data.c
      switch command
        when 'createRoom'
          roomName = data.name
          ServerAPI.createRoom roomName

  stream.setEncoding 'utf8'

  stream.on 'connect', ->
    return

  stream.on 'data', (data) ->
    data = data.split '\u0000'
    data = JSON.parse data[0]
    ServerAPI.readData data

  stream.on 'message', ->
    return

  stream.on 'end', ->
    stream.end()
    return

  return

server.listen PORT
console.log "server running at #{HOST} at port #{PORT}"
