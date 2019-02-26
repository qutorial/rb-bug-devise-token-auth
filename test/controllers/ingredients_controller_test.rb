require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient = ingredients(:one)
  end

  test "should get index" do
    get ingredients_url, as: :json
    assert_response :success
  end

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post ingredients_url, params: { ingredient: { group_id: @ingredient.group_id, name: @ingredient.name, quantity: @ingredient.quantity, recipe_id: @ingredient.recipe_id, unit: @ingredient.unit } }, as: :json
    end

    assert_response 201
  end

  test "should show ingredient" do
    get ingredient_url(@ingredient), as: :json
    assert_response :success
  end

  test "should update ingredient" do
    patch ingredient_url(@ingredient), params: { ingredient: { group_id: @ingredient.group_id, name: @ingredient.name, quantity: @ingredient.quantity, recipe_id: @ingredient.recipe_id, unit: @ingredient.unit } }, as: :json
    assert_response 200
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete ingredient_url(@ingredient), as: :json
    end

    assert_response 204
  end
end
