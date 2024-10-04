require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has email and password" do
    user = build(:user)
    attrs = attributes_for(user)

      user = User.new(attrs)
      assert user.valid?
  end
end
