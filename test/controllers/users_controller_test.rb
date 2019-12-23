require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should sign up a new user' do
    get new_user_url
    assert_response :success

    user = User.new(
      name: 'stuart',
      email: 'stuart@example.gov',
      password: 'secret',
      password_confirmation: 'secret'
    )

    assert_difference 'User.count' do
      post users_url,
        params: {
          user: {
            name: user.name,
            email: user.email,
            password: user.password,
            password_confirmation: user.password_confirmation
          }
        }
    end

    user = User.find_by(email: user.email)
    assert_redirected_to user_path(user)
  end

  test 'should not sign up an invalid new user' do
    get new_user_url
    assert_response :success

    user = User.new(
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    )

    assert_no_difference 'User.count' do
      post users_url,
        params: {
          user: {
            name: user.name,
            email: user.email,
            password: user.password,
            password_confirmation: user.password_confirmation
          }
        }
    end

    assert user.invalid?
  end
end
