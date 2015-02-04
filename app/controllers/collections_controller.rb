class CollectionsController < ApplicationController
  
  def index
    @collections = Collection.all
  end
  
  def new
    @collection = Collection.new
  end
  
  def create
    @collection = Collection.new(colleciton_params)
    @collection.save
    redirect_to collections_path
  end
  
  private
  
  def colleciton_params
    params.require(:collection).permit(:name, :user_id)
  end
  
end
