class CategoriesController < ApplicationController
  before_filter :find_category, :only => [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all.order(created_at: :desc)
  end
  
  def new
    @category = Category.new   # seems safer to add here than in view
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'You created succesfully a category.'
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'You updated your category successfully.'
    else
      render action: 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @category.destroy
    redirect_to categories_url
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def find_category
    @category = Category.find(params[:id])
  end
  
end
