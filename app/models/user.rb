class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :votes

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :followerships, foreign_key: :followee_id, class_name: "Follow"
  has_many :followeeships, foreign_key: :follower_id, class_name: "Follow"
  has_many :followers, through: :followerships, source: :follower
  has_many :followees, through: :followeeships, source: :followee
end
