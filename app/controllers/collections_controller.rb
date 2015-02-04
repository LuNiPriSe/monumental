class CollectionsController < ApplicationController
  
  def index
    @collections = current_user.collections
  end
  
  def new
    @collection = Collection.new(user_id: current_user.id)   # seems safer to add here than in view
  end
  
  def create
    @collection = Collection.new(colleciton_params)
    if @collection.save
      redirect_to collections_path, notice: 'you created succesfully a collection'
    else
      render action: 'new'
    end
  end
  
  private
  
  def colleciton_params
    params.require(:collection).permit(:name, :user_id)
  end
  
end
