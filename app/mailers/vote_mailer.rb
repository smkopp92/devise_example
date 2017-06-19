class VoteMailer < ApplicationMailer
  def new_vote(vote)
    @vote = vote

    mail(
      to: vote.user.email,
      subject: "Thanks for the vote on #{vote.puppy.name}"
    )
  end
end
