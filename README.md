# Sparkler

Spin up a Rails app using all the tools and frameworks we like at [Gaslight][].
Inspired heavily by [thoughtbot](http://thoughtbot.com)'s
[Suspenders](https://github.com/thoughtbot/suspenders).

<a href="http://www.flickr.com/photos/blackmanvision/2601602513/" title="Sparklers by BlackmanVision, on Flickr"><img src="http://farm4.staticflickr.com/3229/2601602513_f9c989ac0a.jpg" width="500" height="333" alt="Sparklers"></a>

You'll get stuff like:

* [Haml](http://haml.info/)
* [Sass](http://sass-lang.com/)
* [Compass](http://compass-style.org)
* [ZURB's Foundation](http://foundation.zurb.com/)
* [Rspec](https://www.relishapp.com/rspec)
* [Foreman](http://ddollar.github.com/foreman/) setup using
  [dotenv](https://github.com/bkeepers/dotenv-rails)
* [High Voltage][] (for static pages)
* A staging environment.
* An application layout rendering flash messages of any key/value.
* A responsive layout using HTML5.
* Vendored Rubygems in `vendor/ruby` and packaged gems in `vendor/cache`
  becuase [Vendor Everything][] **still** applies.

Optionally, you can create a local-to-the-app Postgresql cluster. Why do that,
you ask? Well your app becomes totally independent, first of all. In addition,
when you use a tool like Foreman, PG's logs are output right along with your
other services. It's pretty nice having all app specific output in one place.

It's not my idea, by the way.

![](http://cdmwebs.com/s/Peter_van_Hardenberg_%28pvh%29_on_Twitter-20120909-215619.jpg)

## Installation

Install the gem: `gem install sparkler`.

## Usage

* Run the `sparkler` command with no arguments and you'll see the default Rails
  help. We've added a couple of options, though, which aren't currently listed.
* Most of the time, you'll want to do:

  `sparkler NEW_APP`

* To generate a local PG cluster:

  `sparkler NEW_APP --local-database`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

sparkler is Copyright © 2008-2013 Gaslight. It is free software, and may be redistributed under
the terms specified in the LICENSE file.

[Gaslight]: http://gaslight.co
[Vendor Everything]: http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
[RDiscount]: https://github.com/rtomayko/rdiscount
[High Voltage]: https://github.com/thoughtbot/high_voltage
