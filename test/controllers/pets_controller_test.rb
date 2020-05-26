require "test_helper"

describe PetsController do
  it "must get index" do
    get pets_path 

    must_respond_with :success

    expect(response.header['Content-Type']).must_include('json')
    must_respond_with :ok
  end

  it "will return proper fields for a list of pets" do 

    pet_fields = ["id","name","age","owner","species"].sort 

    get pets_path 

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array

    body.each do |pet|
      expect(pet).must_be_instance_of Hash
      expect(pet.keys.sort).must_equal pet_fields
    end 
  
  end 


  it "will show empty array if no pets" do 

    Pet.destroy_all

    get pets_path 

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0 
  end 

end
