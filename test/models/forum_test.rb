require "test_helper"

# Let's finish the work first.
class ForumTest < ActiveSupport::TestCase
  test "forum_need_owner" do
    result = Forum.where(user: nil)
    assert_nil result
  end
end
