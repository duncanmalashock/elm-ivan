var connect = require('connect');
var serveStatic = require('serve-static');
var socketIO = require('socket.io').listen(1025);
connect().use(serveStatic(__dirname)).listen(8080, function(){
    console.log('Web server running at localhost:8080');
});

var SerialPort = require("serialport");
var portName = process.argv[2];

var numHeaderBytes = 4;
var numDataBytesPerLine = 4;
var numTailBytes = 4;

var numBufferIndexBits = 8;

var xByteLength = 12;
var yByteLength = 12;
var zByteLength = 6;

var debugMode = false;

var printIfDebug = function(message) {
  if (debugMode) {
    console.log(message);
  }
}

var maxValueForNumBits = function(numBits) {
  return Math.pow(2, numBits) - 1;
}

var encodePointIntoBytes = function(point) {
  var byteIndex = 0;
  var xByte = (point[0] & maxValueForNumBits(xByteLength));
  var yByte = (point[1] & maxValueForNumBits(yByteLength));
  var zByte = (point[2] & maxValueForNumBits(zByteLength));
  var encodedData = 0;
  encodedData = encodedData | xByte;
  byteIndex += xByteLength;
  encodedData = encodedData | (yByte << byteIndex);
  byteIndex += yByteLength;
  encodedData = encodedData | (zByte << byteIndex);
  byteIndex += zByteLength;
  encodedData = encodedData | (2 << byteIndex);
  return encodedData;
}

var constructBufferOutput = function(points) {
  var bufferLength = numHeaderBytes + (numDataBytesPerLine * points.length) + numTailBytes;
  var buffer = new Buffer(bufferLength);
  var bufferIndex = 0;
  for (x = 0; x < numHeaderBytes; x++) {
    buffer[bufferIndex++] = 0;
  }
  for (j = 0; j < points.length; j++) {
    dataForBuffer = encodePointIntoBytes(points[j]);
    for (k = numDataBytesPerLine - 1; k >= 0; k--) {
      buffer[bufferIndex++] = (dataForBuffer >> (k * 8)) & maxValueForNumBits(numBufferIndexBits);
    }
  }
  for (x = 0; x < numTailBytes; x++) {
    buffer[bufferIndex++] = 1;
  }
  return buffer;
}

var sendBufferToSerial = function(port, buffer) {
  port.write(buffer, function (error, result) {
    if (error) {
      console.log(error.message);
      return;
    }
    if (result) {
      console.log(result);
      return;
    }
    printIfDebug("Sent buffer to serial port");
    return;
  });
}

var myPort = new SerialPort(portName, {
  baudRate: 9600,
  autoOpen: false
});

myPort.open(function (error) {
  if (error) {
    console.log('Couldn\'t open serial port\n' + error.message);
  } else {
    console.log('Serial port open');
    socketIO.sockets.on('connection', function (socket) {
      console.log('Socket connection open');
      socket.on('sendToSerial', function (data) {
        sendBufferToSerial(myPort, constructBufferOutput(data));
      });
    });
  }
});
