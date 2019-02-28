require 'set'

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_recipe, only: [:show, :update, :destroy]

  # GET /recipes
  def index
    @recipes = current_user.recipes.order(:name)
    render json: @recipes
  end

  # GET /recipes/1
  def show
    groups = @recipe.groups
    ingredients = @recipe.ingredients
    render json: {"recipe": @recipe, "groups": groups, "ingredients": ingredients}
  end

  # POST /recipes
  def create
    @recipe = current_user.recipes.build(recipe_params)
    process_full_post
    if @recipe.save
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1
  def update
    process_full_post
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def process_full_post

    # collect association of ids (negative are new) to groups
    groupsHash = Hash.new
    groups_params["groups"].each do |group| 
      grp = Group.find_by(id: group["id"])
      
      # check that it belongs to the right user
      if not grp.nil? then
        if grp.recipe.user != current_user
          render json: "Not allowed to manipulate other persons groups", status: :unauthorized
          return
        end
      end

      # create new or update existing
      if grp.nil? then # a new group
        grp = Group.create(name: group["name"], recipe: @recipe)
      else 
        grp.update(name: group["name"])
      end
      # add to hash for recipies
      groupsHash[group["id"]] = grp
    end

    # delete other deleted groups
    @recipe.groups.each do |group|
      if not groupsHash.has_value? group then
        group.destroy
      end
    end

    ingredientsSet = Set.new
    ingredients_params["ingredients"].each do |ingredient|
      ingr = Ingredient.find_by(id: ingredient["id"])
      if not ingr.nil? then
        if ingr.recipe.user != current_user
          render json: "Not allowed to manipulate other persons ingredients", status: :unauthorized
          return
        end
      end

      grp = nil
      if groupsHash.key? ingredient["group_id"] then
        grp = groupsHash[ingredient["group_id"]]
      end

      if ingr.nil? then
        ingr = Ingredient.create(name: ingredient["name"], 
          quantity: ingredient["quantity"], 
          unit: ingredient["unit"],
          recipe: @recipe,
          group: grp,
          order: ingredient["order"])
      else
        ingr.update(name: ingredient["name"], 
          quantity: ingredient["quantity"], 
          unit: ingredient["unit"],
          order: ingredient["order"])
      end

      ingredientsSet.add(ingr)
    end

    @recipe.ingredients.each do |ingredient|
      if not ingredientsSet.include? ingredient then
        ingredient.destroy
      end
    end

  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.permit(:name, :preparation, :image, :multiplier)
    end

    def groups_params
      params.permit(groups: [:id, :name])
    end

    def ingredients_params
      params.permit(ingredients: [:id, :name, :quantity, :unit, :group_id, :order])
    end
      

    def check_recipe
      if @recipe.user != current_user
      	render json: {}, status: :unauthorized
      end
    end
end
