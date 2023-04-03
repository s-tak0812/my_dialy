require "test_helper"

class Public::BlogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_blogs_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_blogs_edit_url
    assert_response :success
  end

  test "should get show" do
    get public_blogs_show_url
    assert_response :success
  end
end
