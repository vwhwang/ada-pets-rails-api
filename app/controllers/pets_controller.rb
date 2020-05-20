class PetsController < ApplicationController

  def index
    @pets = Pet.all
    # render json: { ready_for_lunch: "yessss" }, status: :ok
  end

end
