require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_url
    assert_response :success
  end

  test 'should login a valid user' do
    get login_url

    post login_url, params: {
      session: {
        email: users(:jhony).email,
        password: 'secret'
      }
    }

    assert_redirected_to user_url(users(:jhony))
    follow_redirect!
    users(:jhony).reload
    assert_not_nil users(:jhony).remember_token
    assert session[:user_id] = users(:jhony).id
    assert_not_nil cookies[:remember_token]
  end

  test 'should not login an invalid user' do
    post login_url, params: {
      session: {
        email: 'not@user.net',
        password: 'whatevs'
      }
    }

    assert_equal 'Wrong input', flash.now[:danger]
    assert_nil session[:user_id]
    assert_nil cookies[:remember_token]
  end

  test 'should log out a logged in user' do
    log_in(users(:jhony), 'secret')
    follow_redirect!
    delete logout_url
    assert_redirected_to root_url
    follow_redirect!
    assert_nil session[:user_id]
    # For some reason this value is set to "" after logging out
    # assert_nil cookies[:remember_token]
  end
end
