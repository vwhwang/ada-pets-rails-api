class PetsController < ApplicationController
  def index
    pets = Pet.all.order(:name)

    render json: pets.as_json(only: [:id, :name, :age, :owner, :species]), 
                              status: :ok
  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet.nil?
      render json: {
        ok: false,
        message: 'Not found',
      }, status: :not_found

      return
    end

    render json: pet.as_json(only: [:id, :name, :age, :owner, :species]), 
                              status: :ok
  end
end
