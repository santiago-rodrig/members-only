# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'bad formatted email is invalid' do
    invalid = User.new(
      name: 'bob',
      email: 'bob@example',
      password: 'secret',
      password_confirmation: 'secret'
    )

    valid = User.new(
      name: 'barbara',
      email: 'barbara@important.net',
      password: 'hidden',
      password_confirmation: 'hidden'
    )

    assert valid.save
    assert_not invalid.save
  end

  test 'name, email, password must be present' do
    invalid = User.new(
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    )

    assert_not invalid.save
    assert_equal 7, invalid.errors.count
  end

  test 'premium is false by default' do
    assert_not users(:jhony).premium?
  end

  test 'remember_token is null by default' do
    assert_nil users(:jenny).remember_token
  end

  test 'has many posts' do
    assert_respond_to users(:jhony), :posts
  end

  test 'name and email must be unique' do
    user = User.new(
      name: 'jhony',
      email: 'jhony@example.org',
      password: 'secret',
      password_confirmation: 'secret'
    )

    assert user.invalid?
    assert_equal 2, user.errors.count
    user.name = 'stuart'
    assert user.invalid?
    assert_equal 1, user.errors.count
    user.email = 'stuart@example.com'
    assert user.valid?
    assert_equal 0, user.errors.count
  end
end
