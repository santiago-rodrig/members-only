# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'title and body must be present' do
    post = Post.new(
      title: '',
      body: ''
    )

    assert post.invalid?
  end

  test 'title must be unique' do
    post1 = Post.new(
      title: 'Title',
      body: 'Body',
      user_id: users(:jhony).id
    )

    post2 = Post.new(
      title: 'Title',
      body: 'Buddy',
      user_id: users(:jenny).id
    )

    assert post1.valid?
    post_1.save
    assert post2.invalid?
    assert_equal 1, post2.errors.count
  end

  test 'has an user' do
    assert_respond_to posts(:post_1), :user
  end
end
