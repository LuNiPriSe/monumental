class MonumentsController < ApplicationController
  before_filter :find_monument, :only => [:show, :edit, :update, :destroy]
  
  def index
    @monuments = Monument.all.order(created_at: :desc)  #TO DO just the ones from the user
  end
  
  def new
    @monument = Monument.new(step: 1, collection_id: params[:collection_id])
  end
  
  def create
    @monument = Monument.new(monument_params)
    if @monument.save
      redirect_to edit_monument_path(@monument)
    else
      render action: 'new'
    end
  end
  
  def edit
    if @monument.step != 3
      @monument.step += 1
      @picture = Picture.new if @monument.step == 2 # in order to create new picture
    end
  end
  
  def update
    if @monument.update(monument_params)
      if @monument.step != 3
        @monument.step += 1
        render action: 'edit'
      else
        redirect_to monuments_path, notice: 'You created succesfully a monument.'
      end
    end
  end
  
  def destroy
    @monument.destroy
    redirect_to monuments_url
  end
  
  private
  
  def monument_params
    params.require(:monument).permit(:collection_id, :name, :description, :public, :public_approved, :step)
  end
  
  def find_monument
    @monument = Monument.find(params[:id])
  end
  
end
