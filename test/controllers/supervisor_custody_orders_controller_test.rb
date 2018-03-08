require 'test_helper'

class SupervisorCustodyOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get supervisor_custody_orders_index_url
    assert_response :success
  end

end
