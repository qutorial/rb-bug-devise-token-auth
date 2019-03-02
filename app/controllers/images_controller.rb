class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :destroy]
  before_action :authenticate_user!
  before_action :set_recipe, only: [:create, :index]
  before_action :check_recipe, only: [:create, :index]

  def index
    render json: @recipe.images
  end

  # GET /images/1
  def show
    send_file "#{imageFile}", type: "image", disposition: "inline"
  end


  # POST /images
  def create
    s = data_param[:data]
    folder = Rails.configuration.images["images_folder"]
    filename = random_string
    path = File.join(folder, filename)
    
    File.open(path, "wb") do |f| 
      # conversion from binary unicode string to bytes
      f.write(s.unpack("U*").pack("C*")) 
    end

    @image = Image.new(image_params)
    @image.filename = filename;

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    if @image.recipe.user != current_user
      render json: "Not allowed to delete someone else's images", status: :unauthorized
    else
      @image.destroy
    end
  end

  private
    def random_string
      "#{SecureRandom.urlsafe_base64}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.permit(:recipe_id)
    end

    def data_param
      params.permit(:data)
    end

    def set_recipe
      @recipe = Recipe.find(params.permit(:recipe_id)["recipe_id"])
    end

    def check_recipe
      if @recipe.user != current_user
      	render json: {}, status: :unauthorized
      end
    end

    def imageFile
      folder = Rails.configuration.images["images_folder"]
      filename = @image.filename
      path = File.join(folder, filename)
      path
    end
end


