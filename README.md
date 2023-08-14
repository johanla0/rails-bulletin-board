## Hexlet tests and linter status:
[![Actions Status](https://github.com/johanla0/rails-project-65/workflows/hexlet-check/badge.svg)](https://github.com/johanla0/rails-project-65/actions)
[![Ruby on Rails CI](https://github.com/johanla0/rails-project-65/actions/workflows/rubyonrails.yml/badge.svg?branch=main)](https://github.com/johanla0/rails-project-65/actions/workflows/rubyonrails.yml)

## What is it?
Just a simple bulletin blog example with a pinch of Hotwire. Everybody can read it, but you need to sign up via omniauth to post new bulletins.
- bulletin model relies on the state machine
- `admin` can review and manage categories and bulletins' states within a separate namespace

## App can be found here
https://rails-project-65.onrender.com/

## Development
### Install locally (no docker containers currently)

`make install`

### Start a new branch

`make branch feature_name`

### Bundle js and watch the stimulus controllers directory

`make esbuild`

### Check styles (slim, js, scss) and run tests (models, controllers) before pushing

`make check`

### Push

`make push`
