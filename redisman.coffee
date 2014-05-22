redis = require 'redis'
url = require "url"
rtgURL = process.env.REDISTOGO_URL

exports.createClient = cli = ->
    return redis.createClient() unless rtgURL
    rtg = url.parse rtgURL
    client = redis.createClient rtg.port, rtg.hostname
    client.auth rtg.auth.split(":")[1]
    client

exports.createSessionStore = (session) ->
    RedisStore = require('connect-redis')(session)
    new RedisStore client: cli()

exports.createSocketioStore = ->
    Store = require('socket.io').RedisStore
    new Store
        redis: redis
        redisPub: cli()
        redisSub: cli()
        redisClient: cli()