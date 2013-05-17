Homu
====
Home controller using [Sinatra::RocketIO::Linda](http://github.com/shokai/sinatra-rocketio-linda)

* https://github.com/shokai/homu


Clone
-----

    % git clone git://github.com/shokai/homu.git


Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Run
---

set HTTP port 5000

    % bundle exec rackup config.ru -p 5000

set WebSocket port 5001

    % WS_PORT=5001 bundle exec rackup config.ru -p 5000
