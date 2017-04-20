# elm-ivan
Vector graphics for oscilloscope in Elm

## Usage
Node:  
Install [Node](https://nodejs.org/en/) and [NPM](https://www.npmjs.com/)  
Install the connect, serve-static, and [serialport](https://github.com/EmergingTechnologyAdvisors/node-serialport/) modules:  
`npm install serialport`  
`npm install connect`  
`npm install serve-static`  
Run server.js with node, passing a serial port name, i.e.  
`node server.js /dev/tty.usbmodem2752111`

## Notes for working on this repo:
Elm:  
Install [Elm](http://elm-lang.org/)  
Compile the Elm source:  
`cd elm-src`  
`elm-make Main.elm --output=../js/elm.js`

SCSS:  
`cd style`  
`sass --watch scss:css`
