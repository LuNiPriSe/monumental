class MonumentsController < ApplicationController
  before_filter :find_monument, :only => [:show, :edit, :update, :destroy]
  
  def index
    @monuments = Monument.all  #TO DO just the ones from the user
  end
  
  def new
    @monument = Monument.new
    @monument.collection_id = params[:collection_id]
  end
  
  def create
    @monument = Monument.new(monument_params)
    if @monument.save
      redirect_to monuments_path, notice: 'You created succesfully a collection.'
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @monument.update(monument_params)
      redirect_to monuments_path, notice: 'You updated your collection successfully.'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @monument.destroy
    redirect_to monuments_url
  end
  
  private
  
  def monument_params
    params.require(:monument).permit(:collection_id, :name, :description, :public, :public_approved)
  end
  
  def find_monument
    @monument = Monument.find(params[:id])
  end
  
end
