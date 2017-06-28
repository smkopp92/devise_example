class FollowersController < ApplicationController
  before_action :check_same_user!

  def index
    @followers = current_user.followers
  end
end
