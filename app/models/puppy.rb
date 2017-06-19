class Puppy < ApplicationRecord
  has_many :votes

  validates :name, presence: true
  validates :img_url, presence: true

  def score
    self.votes.where(upvote: true).count - self.votes.where(upvote: false).count
  end
end
