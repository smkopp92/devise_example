class FolloweesController < ApplicationController
  before_action :check_same_user!

  def index
    @followees = current_user.followees
  end
end
