var firebase = require("firebase");
var fs = require('fs');

var config = {
    databaseURL: "https://fanlink-stage02.firebaseio.com",
};
firebase.initializeApp(config);

var db = firebase.database();

var rooms = [1];

var log_stream = fs.createWriteStream("listener.log");

log_stream.once('open', function(fd) {
  rooms.forEach(function(elem) {
    var ref = db.ref("test/rooms/" + elem + "/last_message");
    ref.on("value", function(snapshot) {
        var d = new Date();
        var msg = snapshot.val();
        var create_time = Date.parse(msg["create_time"])
        log_stream.write("Body: " + msg["body"] + " -- Created: " + msg["create_time"] + " -- Current: " + d.toString() + " -- Lag: " + (d.getTime() - create_time) + "\n");
      }, function (errorObject) {
        log_stream.write("The read failed: " + errorObject.code + "\n");
    });
  });
});
