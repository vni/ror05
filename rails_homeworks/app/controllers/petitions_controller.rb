class PetitionsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def index
    @petitions = Petition.all
    @petitions = @petitions.where(user: current_user) if params[:my]
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def create
    petition = current_user.petitions.create(permitted_params)
    redirect_to petition
  end

  def new
    @petition = current_user.petitions.new
  end

  private

  def permitted_params
    params.require(:petition).permit(:id, :title, :body)
  end
end
