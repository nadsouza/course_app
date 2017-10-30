class CategoriesController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: [:create, :new]
  before_action :admin_only, only: [:destroy]

  def edit
    @category = Category.find(params[:id])
  end

  def index
  end

  def create
    new_category = params.require(:category).permit(:name)
    @category = Category.new(new_category)

    if @category.save
      flash_success("Successfully created #{@category.name} category.", categories_path)
    else
      render 'new'
    end
  end

  def destroy
    # Delete course
    category = Category.find(params[:id]).destroy
    flash_success("Successfully deleted #{category.name} category!", :back)
  end

  def new
    @category = Category.new(name: "")
  end

  def show
    @category = Category.find(params[:id])
    @courses = @category.courses
  end

  def update
    @category = Category.find(params[:id])

    # Get user params
    category_params = params.require(:category).permit([:name])

    @category.assign_attributes(category_params)

    if @category.save
      flash_success("Successfully updated #{@category.name} category!", categories_path)
    else
      render 'edit'
    end
  end
end
