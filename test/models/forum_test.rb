require "test_helper"

class ForumTest < ActiveSupport::TestCase
  test "forum_need_owner" do
    test_forum = Forum.where(user: nil)
    assert_nil test_forum
  end
end
