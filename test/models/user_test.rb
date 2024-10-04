require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has email and password" do
      user = create(:user)
      assert user.valid?
  end
end
