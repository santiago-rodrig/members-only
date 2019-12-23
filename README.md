# Members Only

This is a web app where only users with premium status can see the authors of
the posts written by regular users.

## Features

- Users sign up
- Logged in status
- Remembering of sessions
- Posts creation
- Users edition
- Users profile
- Log in and log out
- Bootstrap

## Setup

### Requirements

- `ruby` 2.6.5
- `yarn` 1.19.2
- `sqlite3` 3.27.2
- `bundler` 2.0.2

### Installation

Issue the following command **as a regular user**.

```shell
bundle install && bundle update && yarn install --check-files
```

Then, fire up the application with `rails s`, and take a look by visiting the
URI `localhost:3000`.
