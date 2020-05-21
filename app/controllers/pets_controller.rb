class PetsController < ApplicationController

  def index
    pets = Pet.all.as_json(only: [:id, :name, :age, :owner, :species])
    render json: pets, status: :ok
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render json: pet.as_json(only: [:id]), status: :created
      return
    else
      render json: {
          ok: false,
          errors: pet.errors.messages
        }, status: :bad_request
      return
    end
  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet
      render json: pet.as_json(only: [:id, :name, :age, :owner, :species])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end

  private

  def pet_params
    return params.require(:pet).permit(:name, :age, :owner, :species)
  end

end
