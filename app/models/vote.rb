class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :puppy

  validates :user_id, presence: true
  validates :puppy_id, presence: true
end
