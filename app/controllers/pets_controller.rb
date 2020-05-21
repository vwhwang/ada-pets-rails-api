class PetsController < ApplicationController
  def index
    @pets = Pet.all.order(:name)

    render json: { ok: 'YESSSSS'}, status: :ok
  end
end
