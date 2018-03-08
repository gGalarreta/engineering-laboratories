require 'test_helper'

class SystemParametersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_parameters_index_url
    assert_response :success
  end

end
