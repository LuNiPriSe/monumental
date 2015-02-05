class CollectionsController < ApplicationController
  before_filter :find_collection, :only => [:show, :edit, :update, :destroy]
  
  def index
    @collections = current_user.collections.order(created_at: :desc)
  end
  
  def new
    @collection = Collection.new(user_id: current_user.id)   # seems safer to add here than in view
  end
  
  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      redirect_to collections_path, notice: 'You created succesfully a collection.'
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @collection.update(collection_params)
      redirect_to collections_path, notice: 'You updated your collection successfully.'
    else
      render action: 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @collection.destroy
    redirect_to collections_url
  end
  
  private
  
  def collection_params
    params.require(:collection).permit(:name, :user_id)
  end
  
  def find_collection
    @collection = Collection.find(params[:id])
  end
  
end
