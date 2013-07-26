require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get calendar" do
    get :calendar
    assert_response :success
  end

  test "should get print_request" do
    get :print_request
    assert_response :success
  end

  test "should get summary_and_detail" do
    get :summary_and_detail
    assert_response :success
  end

  test "should get unlock" do
    get :unlock
    assert_response :success
  end

end
