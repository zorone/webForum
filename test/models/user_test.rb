require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has email and password" do
      user = User.new(email: "user@example.com", password: "testPassword")
      assert user.valid?
  end
end
