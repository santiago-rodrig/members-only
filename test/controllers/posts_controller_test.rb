# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'a logged in user can create a post' do
    post renew_posts_url,
         params: {
           post: {
             title: 'A title',
             body: 'The body'
           }
         }

    assert_redirected_to login_url
    log_in(users(:jhony), 'secret')

    assert_difference 'Post.count' do
      post renew_posts_url,
           params: {
             post: {
               title: 'A title',
               body: 'The body'
             }
           }
    end

    assert_redirected_to root_url
  end
end
