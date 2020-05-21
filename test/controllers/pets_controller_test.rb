require "test_helper"

describe PetsController do

  REQUIRED_PET_FIELDS = ["id", "name", "species", "age", "owner"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "responds with JSON and success" do
      get pets_path

      check_response(expected_type: Array)
    end

    it "responds with an array of pet hashes" do
      # Act
      get pets_path

      # Assert
      body = check_response(expected_type: Array)

      body.each do |pet|
        expect(pet).must_be_instance_of Hash

        expect(pet.keys.sort).must_equal REQUIRED_PET_FIELDS
      end
    end

    it "will respond with an empty array when there are no pets" do
      # Arrange
      Pet.destroy_all

      # Act
      get pets_path

      # Assert
      body = check_response(expected_type: Array)
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

      check_response(expected_type: Hash, expected_status: :created)
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
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "age"
    end

  end

end
