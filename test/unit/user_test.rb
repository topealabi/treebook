require 'test_helper'

class UserTest < ActiveSupport::TestCase
   should have_many(:user_friendships)
   should have_many(:friends)

   test "a user should enter a first name" do
   	user = User.new
     assert !user.save
     assert !user.errors[:first_name].empty?
   end

   test "a user should enter a last name" do
   	user = User.new
     assert !user.save
     assert !user.errors[:last_name].empty?
   end

   test "a user should enter a profile name" do
   	user = User.new
     assert !user.save
     assert !user.errors[:profile_name].empty?
   end

   test "a user should have a unique profile name" do
   	user = User.new
   	user.profile_name = users(:tope).profile_name

     assert !user.save
     puts user.errors.inspect
     assert !user.errors[:profile_name].empty?
   end

   test "profile name must be formatted correctly" do
   	user = User.new(first_name: 'Tope', last_name: 'Alabi', email: 'tope2@ondocrop.com')
    user.password = user.password_confirmation = 'qwerasdf'
   	user.profile_name = "My profile name"

   	assert !user.save
   	assert !user.errors[:profile_name].empty?
   	assert user.errors[:profile_name].include?("Must be formatted correctly.")

   end

   test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Tope', last_name: 'Alabi', email: 'tope2@ondocrop.com')
    user.password = user.password_confirmation = 'qwerasdf'

    user.profile_name = 'topealabi_1'
    assert user.valid?
   end

   test "that no error is raised when trying to access a friend" do
    assert_nothing_raised do
      users(:tope).friends
    end
  end

  test "that creating friendships on a use works" do
    users(:tope).friends << users(:mike)
    users(:tope).friends.reload
    assert users(:tope).friends.include?(users(:mike))
  end
end
