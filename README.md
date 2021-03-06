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
- `rails` 6.0.2.1
- `yarn` 1.19.2
- `sqlite3` 3.27.2
- `bundler` 2.0.2

### Installation

Issue the following command **as a regular user**.

```shell
git clone https://github.com/santiago-rodrig/members-only.git && \
cd members-only && \
bundle install && bundle update && yarn install --check-files && \
rails db:migrate && rails db:seed
```

Then, fire up the application with `rails s`, and take a look by visiting the
URI `localhost:3000`.

Also, there are already 2 users in the database, **jen**, and **john**, **jen**
is a **premium user**. You can log in with jen's account and see that she can
see the authors of the posts listed in the root path of the app. The email of
**jen** is **jen@example.com**, and her password is **secret**.

### Testing

To test that everything is working properly run `rails test` from inside of
the rails app directory.
