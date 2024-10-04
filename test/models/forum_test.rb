require "test_helper"

# Let's finish the work first.
class ForumTest < ActiveSupport::TestCase
  test "forum_need_owner" do
    assert Forum.where(user: nil).empty?
  end
end
