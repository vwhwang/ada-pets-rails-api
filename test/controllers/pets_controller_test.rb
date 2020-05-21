require "test_helper"

describe PetsController do

  describe "index" do
    it "responds with JSON and success" do
      get pets_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of pet hashes" do
      # Act
      get pets_path

      # Get the body of the response
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      body.each do |pet|
        expect(pet).must_be_instance_of Hash

        required_pet_attrs = ["id", "name", "species", "age", "owner"]

        expect(pet.keys.sort).must_equal required_pet_attrs.sort
      end
    end

    it "will respond with an empty array when there are no pets" do
      # Arrange
      Pet.destroy_all

      # Act
      get pets_path
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end

  describe "create" do
    let(:valid_new_pet_data) {
      {
        pet: {
          name: "Stinker",
          species: "Dog",
          age: 13,
          owner: "Grace"
        }
      }
    }

    it "can create a new pet" do
      expect {
        post pets_path, params: valid_new_pet_data
      }.must_differ "Pet.count", 1

      must_respond_with :created
    end

  end

end
