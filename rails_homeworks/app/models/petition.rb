class Petition < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  def already_voted? u
    votes.where(user_id: u.id).any?
  end
end
