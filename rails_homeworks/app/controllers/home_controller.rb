class HomeController < ApplicationController
  def index
    #@petitions = Petition.all.limit(10)
    @petitions = Petition.order(created_at: :desc).limit(10)
  end
end
