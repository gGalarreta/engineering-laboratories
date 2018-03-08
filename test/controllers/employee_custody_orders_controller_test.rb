require 'test_helper'

class EmployeeCustodyOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_custody_orders_index_url
    assert_response :success
  end

end
