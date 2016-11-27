express = require 'express'
app = express()
server = require('http').Server(app)
io = require('socket.io')(server)

app.set 'port', 1337
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'

app.use '/', express.static "#{__dirname}/../public"

app.get '/', (req, res) ->
  res.render 'index'

io.on 'connection', (socket) ->
  # socket.emit 'news',
  #   hello: 'world'
  socket.on 'new-user', (data) ->
    io.emit 'new-user',
      user: data.user
    console.log "#{data.user} connected !"

  socket.on 'new-message', (data) ->
    io.emit 'new-message',
      from: data.from
      message: data.message
    console.log "new message from #{data.from}"

server.listen app.get('port'), ->
  console.log "server listening on #{app.get 'port'}"