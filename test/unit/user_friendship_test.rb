require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works" do 
  	assert_nothing_raised do
  	UserFriendship.create user: users(:tope), friend: users(:mike)

  	end
  end

  test "that creating friendships based on user id and friend id works" do
  	UserFriendship.create user_id: users(:tope).id, friend_id: users(:mike).id
  	assert users(:tope).friends.include?(users(:mike))
  end	
end
