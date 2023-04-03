require "test_helper"

class Public::HouseholdBudgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_household_budgets_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_household_budgets_edit_url
    assert_response :success
  end
end
