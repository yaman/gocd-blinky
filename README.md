# Blink(1) and Build light Build Indicator for MarketPlace Projects

blink(1) is one of the best indicator lights that you can purchase nowadays. If you want to track your CI/CDP pipeline and you have a rotating build champion for the team, this script helps you to monitor your builds.

To get more info about blink(1), please visit their official [site](http://blink1.thingm.com/).

## Installation

If you are using rb-env, it's super simple. Just run:

    bundle install

And you are good to go. Otherwise, go install each gem in `Gemfile` one by one.

## Usage

Script only supports TeamCity right now. However, it shouldn't be too hard to configure for other CI tools. To use:

    chicanery chica.rb

It'll light red if any of the given build ids fail, amber for errors on any build and for the rest it's green.

It will periodically(every 5 seconds) run it.
