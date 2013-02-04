require 'test_helper'

class CsvControllerTest < ActionController::TestCase
  test "should get Upload" do
    get :Upload
    assert_response :success
  end

end
