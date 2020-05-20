class PetsController < ApplicationController

  def index
    pets = Pet.all.as_json(only: [:id, :name, :age, :owner, :species])
    render json: pets, status: :ok
  end

end
