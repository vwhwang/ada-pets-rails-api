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
    let(:pet_data) {
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
        post pets_path, params: pet_data
      }.must_differ "Pet.count", 1

      must_respond_with :created
    end

    it "will respond with bad_request for invalid data" do
      # Arrange - using let from above
      # Our PetsController test should just test generically
      # for any kind of invalid data, so we will randomly pick
      # the age attribute to invalidate
      pet_data[:pet][:age] = nil

      expect {
        # Act
        post pets_path, params: pet_data

      # Assert
      }.wont_change "Pet.count"
    
      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "age"
    end

  end

end
