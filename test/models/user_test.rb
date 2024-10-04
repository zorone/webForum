require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user has email" do
      user = create(:user)
      attrs = attributes_for(user)

      user = User.new(attrs)
      assert user.valid?
  end
end
