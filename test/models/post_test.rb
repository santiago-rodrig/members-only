require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'title and body must be present' do
    post = Post.new(
      title: '',
      body: '',
    )

    assert post.invalid?
  end

  test 'title must be unique' do
    post_1 = Post.new(
      title: 'Title',
      body: 'Body',
      user_id: users(:jhony).id
    )

    post_2 = Post.new(
      title: 'Title',
      body: 'Buddy',
      user_id: users(:jenny).id
    )

    assert post_1.valid?
    post_1.save
    assert post_2.invalid?
    assert_equal 1, post_2.errors.count
  end

  test 'has an user' do
    assert_respond_to posts(:post_1), :user
  end
end
