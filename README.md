# Reviews

[![Build Status](https://secure.travis-ci.org/futhr/spree_reviews.png?branch=master)](http://travis-ci.org/futhr/spree_reviews)
[![Dependency Status](https://gemnasium.com/futhr/spree_reviews.png)](https://gemnasium.com/futhr/spree_reviews)
[![Coverage Status](https://coveralls.io/repos/futhr/spree_reviews/badge.png?branch=master)](https://coveralls.io/r/futhr/spree_reviews)

Straightforward review/rating facility.

## Installation

Add to your `Gemfile`:
```ruby
gem 'spree_reviews', github: 'spree/spree_reviews'
```

Run

    bundle install
    rails g spree_reviews:install
    rake db:migrate

## Usage

Action _submit_ in _reviews_ controller - goes to review entry form

Users must be logged in to submit a review

Three partials:

- `./app/views/products/_rating.html.erb` -- display number of stars
- `./app/views/products/_shortrating.html.erb` -- shorter version of above
- `./app/views/products/_review.html.erb` -- display a single review

Administrator can edit and/or _approve_ and/or delete reviews.

## Implementation

Reviews table is quite obvious - and note the _approved_ flag which is for the
administrator to update. Ratings table holds current fractional value - avoids frequent recalc.

## TODO

- Partial(s) for selecting _approved_ reviews to read
- REST routes needed in some places?
- Only accept ratings for approved reviews?
- Allow stand alone rating values?

## Discussion

Some points which might need modification in future:
 - I don't track the actual user on a review (just their "screen name" at the
   time), but we may want to use this information to avoid duplicate reviews
   etc.

 - Rating votes are tied to a review, to avoid spam. However: ratings are
   accepted whether or not the review is accepted. Perhaps they should only
   be counted when the review is approved.

## Contributing

In the spirit of [free software][1], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing [translations][4]
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes and follow this [Style Guide][5]
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2013 Paul Callaghan, released under the [New BSD License][3]

[1]: http://www.fsf.org/licensing/essays/free-sw.html
[2]: https://github.com/spree/spree_reviews/issues
[3]: https://github.com/spree/spree_reviews/tree/master/LICENSE.md
[4]: http://www.localeapp.com/projects/4921
[5]: https://github.com/thoughtbot/guides
