class PetitionsController < ApplicationController
  before_action :authorize, only: [:new, :create]

  def index
    @petitions = Petition.all
    if params[:my]
      @petitions = @petitions.where(user: current_user)
      render 'my_petitions'
    end
  end

  def new
    @petition = current_user.petitions.new
  end

  def create
    petition = current_user.petitions.create(permitted_params)
    redirect_to petition
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def edit
    @petition = current_user.petitions.find(params[:id])
  end

  def update # POST /petitions/:id
    petition = current_user.petitions.find(params[:id])
    petition.update(permitted_params)
    redirect_to petition, notice: "Петиция обновлена"
  end

  def destroy
    petition = current_user.petitions.find(params[:id])
    petition.destroy
    redirect_to action: :index, notice: "Петиция удалена"
  end

  private

  def permitted_params
    params.require(:petition).permit(:id, :title, :body)
  end
end
