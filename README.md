Linda-Base
==========
Home controller using [Sinatra::RocketIO::Linda](http://github.com/shokai/sinatra-rocketio-linda)

* https://github.com/shokai/linda-base


Demo
----

* http://linda.shokai.org
* http://linda-base.herokuapp.com


Clone
-----

    % git clone git://github.com/shokai/linda-base.git


Requirements
------------
- Ruby 1.8.7 ~ 2.0.0
- memcached


Install Dependencies
--------------------

    % brew install memcached
    % gem install bundler
    % bundle install


Config
------

[Register new Application](https://github.com/settings/applications) on GitHub

    % export GITHUB_APP_ID=abcd1234asdf
    % export GITHUB_APP_SECRET=asdf135hujikohujiko71sdfcxvoip

session

    % export SESSION_SECRET=foobar1234


Run
---

start memcache

    % memcached -vv -p 11211 -U 11211

set HTTP port 5000

    % bundle exec rackup config.ru -p 5000

set WebSocket port 5001

    % WS_PORT=5001 bundle exec rackup config.ru -p 5000

disable WebSocket

    % WEBSOCKET=false bundle exec rackup config.ru -p 5000


Deploy on Heroku
----------------

    % heroku create --stack cedar linda-base
    % heroku addons:add memcachier:dev
    % heroku config:set WEBSOCKET=false
    % heroku config:set GITHUB_APP_ID=abcd1234asdf
    % heroku config:set GITHUB_APP_SECRET=asdf135hujikohujiko71sdfcxvoip
    % heroku config:set SESSION_SECRET=foobar1234
    % git push heroku master
    % heroku open

