require "test_helper"

# Let's finish the work first.
class ForumTest < ActiveSupport::TestCase
  include Devise::Test::ControllerHelpers

  test "forum_need_owner" do
    assert_nil Forum.where(user: nil)
  end
end
