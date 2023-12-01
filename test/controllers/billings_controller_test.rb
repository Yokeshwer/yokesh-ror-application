require "test_helper"

class BillingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get billings_index_url
    assert_response :success
  end
end
