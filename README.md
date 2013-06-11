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


Install Dependencies
--------------------

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

set HTTP port 5000

    % bundle exec rackup config.ru -p 5000

set WebSocket port 5001

    % WS_PORT=5001 bundle exec rackup config.ru -p 5000

disable WebSocket

    % WEBSOCKET=false bundle exec rackup config.ru -p 5000


Deploy on Heroku
----------------

    % heroku create --stack cedar linda-base
    % heroku config:set WEBSOCKET=false
    % git push heroku master
