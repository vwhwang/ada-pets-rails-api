require "test_helper"

describe PetsController do
  PET_FIELDS = ["id", "name", "age", "owner", "species"].sort

  it "must get index" do
    get pets_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of pets" do

    # Act
    get pets_path

    # Get the body of the response
    # as an array or hash
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array

    body.each do |pet|
      expect(pet).must_be_instance_of Hash
      expect(pet.keys.sort).must_equal PET_FIELDS
    end
  end

  it "returns an empty array if no pets exist" do
    Pet.destroy_all

     # Act
     get pets_path

     # Get the body of the response
     # as an array or hash
     body = JSON.parse(response.body)
 
     # Assert
     expect(body).must_be_instance_of Array
     expect(body.length).must_equal 0
  end

  describe "show" do
    # Nominal
    it "will return a hash with the proper fields for an existing pet" do
      pet = pets(:stinker)

      # Act
      get pet_path(pet.id)

      # Assert
      must_respond_with :success


      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal PET_FIELDS
    end

    # Edge Case
    it "will return a 404 request with json for a non-existent pet" do
      get pet_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end

end
