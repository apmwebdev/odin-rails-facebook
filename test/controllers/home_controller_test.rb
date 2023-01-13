require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get landing_page" do
    get home_landing_page_url
    assert_response :success
  end

  test "should get newsfeed" do
    get home_newsfeed_url
    assert_response :success
  end
end
