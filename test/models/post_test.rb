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
    )

    post_2 = Post.new(
      title: 'Title',
      body: 'Buddy'
    )

    assert post_1.save
    assert post_2.invalid?
    assert_equal 1, post.errors.count
  end
end
