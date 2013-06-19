
gpio = require "pi-gpio"
fs = require "fs"
exec = require("child_process").exec

https = require "https"
express = require "express"
OAuth2 = require("OAuth").OAuth2

config = JSON.parse fs.readFileSync('config.json')

ssl =
  key: fs.readFileSync config.ssl.key_path
  cert: fs.readFileSync config.ssl.cert_path


FoursquareClient = new OAuth2(
  config.foursquare.client_id,
  config.foursquare.client_secret,
  "https://foursquare.com",
  "/oauth2/authenticate",
  "/oauth2/access_token",
  null)


app = express()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session(config.session)

app.get '/', (request, response) ->
  response.send 200, "Simple Foursquare PushAPI 2 RaspberryPI"

app.get '/foursquare/connect', (request, response) ->
  console.log request.session
  if request.session.foursquare
    response.redirect '/'
  else
    response.redirect FoursquareClient.getAuthorizeUrl(
      response_type: config.foursquare.response_type
      redirect_uri: config.foursquare.redirect_uri
    )


app.get '/foursquare/callback', (request, response) ->
  code = request.param 'code'
  FoursquareClient.getOAuthAccessToken code,
    {
      redirect_uri: config.foursquare.redirect_uri
      grant_type: config.foursquare.grant_type
    },
    (err, access_token, refresh_token, results) ->
      if err
        console.log err
      else
        request.session.foursquare =
          access_token: access_token
      response.redirect '/'

app.post '/foursquare/checkin', (request, response) ->
  gpio.open 16, "output", (err) ->           #// Open pin 16 for output
    unless err
      gpio.write 16, 1, () ->                #// Set pin 16 high (1)
        gpio.close 16                        #// Close pin 16
  response.send 204



server = https.createServer ssl, app

server.listen 8888
