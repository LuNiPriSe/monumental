class MonumentsController < ApplicationController
  
  def index
    @monuments = Monument.all
  end
  
  def new
    @monument = Monument.new
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
    @monument = Monument.find(params[:id])
  end
  
  def update
    @monument = Monument.find(params[:id])
    if @monument.update(monument_params)
      redirect_to monuments_path, notice: 'You updated your collection successfully.'
    else
      render action: 'edit'
    end
  end
  
  private
  
  def monument_params
    params.require(:monument).permit(:collection_id, :name, :description, :public, :public_approved)
  end
  
end
