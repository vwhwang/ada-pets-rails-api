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
  
  end 

end
