# Marozi

This app is named after a [special kind of Lion](http://en.wikipedia.org/wiki/Marozi) which is still not known to exist.

## Installation

This is a very basic installation instruction in order to get the app running (currently only tested on Mac OS)

### Homebrew

All installation steps are based on [homebrew](http://mxcl.github.com/homebrew/).

### Git

The version control is essential for getting the latest code

    ~~~ sh
    $ brew install git
    ~~~~

### Ruby

For running the app, system ruby is sufficient:

    ~~~ sh
    $ brew install ruby
    ~~~

### MongoDB

The datastore needs to be installed on the machine

    ~~~ sh
    $ brew install mongo
    ~~~

### Bundler

[Bundler](http://gembundler.com/) handles the installation of 3rd party libraries (needs to be installed after Ruby):

    ~~~ sh
    $ gem install bundler
    ~~~

## Setup environment

First clone the source code from github:

    ~~~ sh
    $ cd <projects_dir>
    $ git clone git://github.com/leo-clubs/marozi.git
    ~~~

Afterwards change into the directory and install all needed libraries (gems)

    ~~~ sh
    $ cd <projects_dir>/marozi
    $ bundle install --path vendor/local
    ~~~

Now setup the default config

    ~~~ sh
    $ cd <projects_dir>/marozi
    $ bin/setup.sh
    ~~~

## Import XML

For a fully functional system, you'll need a Full Leo Export xml. Afterwards import it into your database (all previously edited data will be gone):

    ~~~ sh
    $ cd <projects_dir>/marozi
    $ mkdir tmp
    $ cp <XML_FILE> tmp/
    $ bundle exec rake db:purge && bundle exec rake 'db:import_from_xml[tmp/LeoExport-FULL.xml]'
    ~~~

## Start application

Now just start the application (Port 3000 must be available)

    ~~~ sh
    $ bundle exec rails s
    ~~~

Now the application is available under [http://localhost:3000](http://localhost:3000)