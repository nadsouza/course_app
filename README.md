# Rapid Application Development Assignment Two
Major group assignment for COSC2675 Rapid Application Development at RMIT University.

* **Johnny Huynh** - S3604367
* **Neil D'Souza** - S3600251

# Heroku Development
Application URL: https://rad-assignment-two.herokuapp.com/

# Additional Gems
We have strictly followed the Gemfile provided from blackboard. However, upon adding AWS support to images, I needed the 'fog' gem to upload images to AWS.

`gem "fog"`

# Practical Class
**2.30 pm - 4.30 pm** - 056.04.082

# Development Environment
To allow actual development on the project code. You must require a development environment for Ruby on Rails (Ruby Framework) to function properly on your local device.

# Last Deployment Log
-----> Ruby app detected
-----> Compiling Ruby/Rails
-----> Using Ruby version: ruby-2.3.4
-----> Installing dependencies using bundler 1.13.7
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
       Warning: the running version of Bundler (1.13.7) is older than the version that created the lockfile (1.14.6). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
       Fetching gem metadata from https://rubygems.org/.........
       Fetching version metadata from https://rubygems.org/..
       Fetching dependency metadata from https://rubygems.org/.
       Using rake 12.0.0
       Using concurrent-ruby 1.0.5
       Using i18n 0.8.1
       Using minitest 5.10.2
       Using thread_safe 0.3.6
       Using builder 3.2.3
       Using erubis 2.7.0
       Using mini_portile2 2.1.0
       Using rack 2.0.3
       Using nio4r 2.0.0
       Using websocket-extensions 0.1.2
       Using mime-types-data 3.2016.0521
       Using arel 7.1.4
       Using execjs 2.7.0
       Using bcrypt 3.1.11
       Using sass 3.4.24
       Using coffee-script-source 1.12.2
       Using method_source 0.8.2
       Using thor 0.19.4
       Using excon 0.55.0
       Using formatador 0.2.5
       Using multi_json 1.12.1
       Using ipaddress 0.8.3
       Using mini_magick 4.7.0
       Using pg 0.18.4
       Using puma 3.4.0
       Using bundler 1.13.7
       Using tilt 2.0.7
       Using turbolinks-source 5.0.3
       Using tzinfo 1.2.3
       Using nokogiri 1.7.2
       Using websocket-driver 0.6.5
       Using mime-types 3.1
       Using autoprefixer-rails 7.1.1
       Using uglifier 3.0.0
       Using rack-test 0.6.3
       Using sprockets 3.7.1
       Using coffee-script 2.4.1
       Using fog-core 1.44.3
       Using turbolinks 5.0.1
       Using activesupport 5.0.3
       Using loofah 2.0.3
       Using mail 2.6.5
       Using bootstrap-sass 3.3.6
       Using fog-json 1.0.2
       Using fog-xml 0.1.3
       Using rails-dom-testing 2.0.3
       Using globalid 0.4.0
       Using activemodel 5.0.3
       Using jbuilder 2.4.1
       Using rails-html-sanitizer 1.0.3
       Using fog-aws 1.3.0
       Using activejob 5.0.3
       Using activerecord 5.0.3
       Using carrierwave 1.1.0
       Using actionview 5.0.3
       Using actionpack 5.0.3
       Using actioncable 5.0.3
       Using actionmailer 5.0.3
       Using railties 5.0.3
       Using sprockets-rails 3.2.0
       Using coffee-rails 4.2.1
       Using font-awesome-rails 4.7.0.2
       Using jquery-rails 4.1.1
       Using rails 5.0.3
       Using sass-rails 5.0.6
       Bundle complete! 26 Gemfile dependencies, 66 gems now installed.
       Gems in the groups development and test were not installed.
       Bundled gems are installed into ./vendor/bundle.
       Bundle completed (2.51s)
       Cleaning up the bundler cache.
       Warning: the running version of Bundler (1.13.7) is older than the version that created the lockfile (1.14.6). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
-----> Installing node-v6.10.0-linux-x64
-----> Detecting rake tasks
-----> Preparing app for Rails asset pipeline
       Running: rake assets:precompile
       Asset precompilation completed (2.07s)
       Cleaning assets
       Running: rake assets:clean
###### WARNING:
       You have not declared a Ruby version in your Gemfile.
       To set your Ruby version add this line to your Gemfile:
       ruby '2.3.4'
       # See https://devcenter.heroku.com/articles/ruby-versions for more information.
-----> Discovering process types
       Procfile declares types     -> web
       Default types for buildpack -> console, rake, worker
-----> Compressing...
       Done: 38.6M
-----> Launching...
       Released v7
       https://rad-assignment-two.herokuapp.com/ deployed to Heroku