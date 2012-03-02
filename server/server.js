(function() {
  var Data, HOST, Model, PORT, Room, User, net, randomId, server, sys, _,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  HOST = 'localhost';

  PORT = 7000;

  net = require('net');

  sys = require('util');

  _ = require('./underscore');

  Data = {
    rooms: []
  };

  randomId = function(len) {
    var chars, id, index;
    if (len == null) len = 8;
    chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
    id = '';
    while (id.length < len) {
      index = Math.random() * chars.length;
      id += chars.substr(index, 1);
    }
    return id;
  };

  Model = (function() {

    function Model(attributes) {
      this.attributes = attributes;
      this.id = randomId();
      this.initialize(this.attributes);
      console.log(this.attributes.name);
    }

    Model.prototype.initialize = function() {};

    Model.prototype.get = function(prop) {
      return this.attributes[prop];
    };

    Model.prototype.set = function(props) {
      var key;
      for (key in props) {
        this.attributes[key] = props[key];
      }
      return this;
    };

    return Model;

  })();

  Room = (function(_super) {

    __extends(Room, _super);

    function Room() {
      Room.__super__.constructor.apply(this, arguments);
    }

    Room.prototype.initialize = function() {};

    return Room;

  })(Model);

  User = (function(_super) {

    __extends(User, _super);

    function User() {
      User.__super__.constructor.apply(this, arguments);
    }

    User.prototype.initialize = function() {};

    return User;

  })(Model);

  server = net.createServer(function(stream) {
    var ServerAPI;
    ServerAPI = {
      createRoom: function(roomName) {
        var room;
        room = new Room({
          name: roomName
        });
        Data.rooms.push(room);
        console.log("room <" + room.id + "> : " + (room.get('name')));
      },
      addUser: function(userName, roomId) {
        var user;
        user = new User({
          name: userName
        });
      },
      readData: function(data) {
        var command, roomName;
        command = data.c;
        switch (command) {
          case 'createRoom':
            roomName = data.name;
            return ServerAPI.createRoom(roomName);
        }
      }
    };
    stream.setEncoding('utf8');
    stream.on('connect', function() {});
    stream.on('data', function(data) {
      data = data.split('\u0000');
      data = JSON.parse(data[0]);
      return ServerAPI.readData(data);
    });
    stream.on('message', function() {});
    stream.on('end', function() {
      stream.end();
    });
  });

  server.listen(PORT);

  console.log("server running at " + HOST + " at port " + PORT);

}).call(this);
