require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has email" do
      user = User.new()
      assert user.valid?
  end
end
