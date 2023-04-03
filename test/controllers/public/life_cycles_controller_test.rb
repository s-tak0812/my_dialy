require "test_helper"

class Public::LifeCyclesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_life_cycles_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_life_cycles_edit_url
    assert_response :success
  end
end
