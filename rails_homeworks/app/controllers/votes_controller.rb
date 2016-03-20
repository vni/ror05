class VotesController < ApplicationController
  def create
    vote = current_user.votes.create(permitted_params)
    redirect_to vote.petition
  end

  before_filter :authorize

  private

    def permitted_params
      params.permit(:petition_id)
    end
end
