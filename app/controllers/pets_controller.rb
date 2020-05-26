class PetsController < ApplicationController
  def index
    @pets = Pet.all
    render json: {does_it_work: "yep"}, status: :ok
  end
end
