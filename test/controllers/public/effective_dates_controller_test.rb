require "test_helper"

class Public::EffectiveDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_effective_dates_index_url
    assert_response :success
  end

  test "should get show" do
    get public_effective_dates_show_url
    assert_response :success
  end
end
