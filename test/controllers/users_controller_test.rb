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

  test 'signup link dissapears if we are already in the new user page' do
    get new_user_url
    assert_select 'a[href=?]', new_user_path, 0
    get root_url
    assert_select 'a[href=?]', new_user_path
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

  test 'should get the posts from the user' do
    log_in(users(:jhony), 'secret')
    get posts_user_url(users(:jhony))
    assert_response :success
  end
end
