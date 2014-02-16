config = require './config'
express = require 'express'
http = require 'http'
path = require 'path'
routes = require './routes'
twitter = require './lib/twitterApiRequest'
moment = require 'moment'

run = ->
  app = express()
  app.configure ->
    app.locals.env = config.currentEnv
#    app.locals.baseUrl = stringUtils.rtrim process.config.baseUrl, '\/'
    app.locals.baseUrl = '/'

    app.set 'title', 'github.com/steida/este'
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.compress()
    app.use express.favicon()

    if config.env.development
      # app.use express.logger 'dev'
      app.locals.pretty = true

    app.use express.bodyParser()
    app.use express.methodOverride()
    
    # Data accessible in all templates
    app.use (req, res, next) ->
      # Header set global
      res.setHeader "Cache-Control", "public, max-age=345600"
      res.setHeader "Pragma", "cache"
      res.setHeader "Expires", moment().utc().add('days', 4).toISOString()
      
      # Header set for api
      if /^\/api\//.test req.path
        res.setHeader "Cache-Control", "no-cache, no-store, must-revalidate"
        res.setHeader "Pragma", "no-cache"
        res.setHeader "Expires", 0

        res.setHeader 'Access-Control-Allow-Origin', "*"
        res.setHeader 'Access-Control-Allow-Headers', 'content-Type,x-requested-with'
        res.setHeader 'Access-Control-Allow-Methods', 'GET,POST,PUT,HEAD,DELETE,OPTIONS'
        
      if req.user
        res.locals.session = req.user
      # Application version
      res.locals.appVersion = require('../../package.json').version
      next()
    
    if config.env.development
      app.use '/client', express.static 'client'
      app.use '/bower_components', express.static 'bower_components'
    else
      app.use '/client', express.static 'client'
      # because Este demos are uncompiled
      app.use '/bower_components', express.static 'bower_components'

    if config.env.development
      app.use express.errorHandler
        dumpExceptions: true
        showStack: true
    else
      app.use (err, req, res, next) ->
        res.status 500
        res.render '500',
          title: '500: Internal Server Error'
          error: error
          
  app.use app.router
  
  app.use (req, res) ->
    res.status 400
    res.render '404',
      title: '404: File Not Found'
  
  accessToken = "594940003-rHXwOwO52n5NHWFcXH4vWtNG08bbY8dKHf3NOnBK"
  accessTokenSecret = "6kjpkMK9QB6a4lZTq9Hze0FEGIiM7RH3eU4t9EOA38L7c"

  app.get '/', routes.index

  app.get "/api/user/:userId(\\d+)/:lastId(\\d+)", (req, res, next) ->
    twitter.getTimeline "user",
      user_id: req.params.userId
      count: 500
      max_id: req.params.lastId if req.params.lastId isnt 0
    , accessToken, accessTokenSecret, (err, res2, body) ->
        return next err if err
        return next body.error if body and body.error
        res.json res2

  http.createServer(app).listen config.server.port, ->
    console.log "Express server listening on port #{config.server.port}"

if config.env.development
  run() if require('piping')()
else
  run()