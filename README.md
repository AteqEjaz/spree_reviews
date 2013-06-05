# Reviews

[![Build Status](https://secure.travis-ci.org/futhr/spree_reviews.png?branch=master)](http://travis-ci.org/futhr/spree_reviews)
[![Dependency Status](https://gemnasium.com/futhr/spree_reviews.png)](https://gemnasium.com/futhr/spree_reviews)
[![Coverage Status](https://coveralls.io/repos/futhr/spree_reviews/badge.png?branch=master)](https://coveralls.io/r/futhr/spree_reviews)

Straightforward review/rating facility.

### Installation

To use the last stable gem release of spree_reviews, add the following to your Gemfile:
```ruby
gem 'spree_reviews'
```

If you'd rather install the latest version with fixes and improvements that have not yet been published to RubyGems, install from git:
```ruby
gem 'spree_reviews', github: 'spree/spree_reviews'
```

Now bundle up with:
```bash
bundle
```

Next, run the rake task that copies the necessary migrations and assets to your project:
```bash
rails g spree_reviews:install
```

And finish with a migrate:
```bash
rake db:migrate
```

Now you should be able to boot up your server with:
```bash
rails s
```

That's all!

### Usage

Action "submit" in "reviews" controller - goes to review entry form

Users must be logged in to submit a review

Three partials:
 - ./app/views/products/_rating.html.erb  -- display number of stars
 - ./app/views/products/_shortrating.html.erb -- shorter version of above
 - ./app/views/products/_review.html.erb  -- display a single review

Administrator can edit and/or approve and/or delete reviews.

### Implementation

Reviews table is quite obvious - and note the "approved" flag which is for the
administrator to update

Ratings table holds current fractional value - avoids frequent recalc...

### TODO

- Partial(s) for selecting _approved_ reviews to read
- REST routes needed in some places?
- Only accept ratings for approved reviews?
- Allow stand alone rating values?

### Discussion

Some points which might need modification in future:
 - I don't track the actual user on a review (just their "screen name" at the
   time), but we may want to use this information to avoid duplicate reviews
   etc.

 - Rating votes are tied to a review, to avoid spam. However: ratings are
   accepted whether or not the review is accepted. Perhaps they should only
   be counted when the review is approved.

## Contributing

* Fork the repo
* Clone your repo `git clone git@github.com:mrhelpful/spree_reviews.git`
* Create branch for your pull request `git checkout -b fix-something`
* Run `bundle`
* Run `bundle exec rake test_app` to create the test application in `spec/dummy`
* Make your changes
* Ensure specs pass by running `bundle exec rake`
* Make sure yor changes has test coverage `open coverage/index.html`
* Submit your pull request

Copyright (c) 2013 Paul Callaghan, released under the New BSD License
