var express = require('express')
var env = require('./env')
var args = process.argv.slice(2)

var app = express()
var environment = env[args[0]]

app.use(express.static(environment.staticfiles))

app.listen(8989, function() {
  console.log('Server started at 8989')
})
