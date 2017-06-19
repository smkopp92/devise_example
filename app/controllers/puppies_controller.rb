class PuppiesController < ApplicationController
  def index
    @puppies = Puppy.all
  end
end
