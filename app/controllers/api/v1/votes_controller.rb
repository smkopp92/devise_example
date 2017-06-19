class Api::V1::VotesController < ApplicationController
  def create
    #Find Vote if exists
    #if the vote doesn't exist
    puppy = Puppy.find(params[:puppy_id])
    vote = Vote.create(puppy: puppy, user: current_user, upvote: params[:vote])
    VoteMailer.new_vote(vote).deliver_now
    render json: { score: puppy.score }
    #if the vote does exist
      #if you clicked the thing that is already in the database
        #Destroy the vote
      #if they are different
        #Update the vote to the new boolean
  end
end
