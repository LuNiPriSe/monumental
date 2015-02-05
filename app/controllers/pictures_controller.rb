class PicturesController < ApplicationController
  before_filter :find_picture, :only => [:edit, :update, :destroy]
  
  # def create
  #   @picture = Picture.new(picture_params)
  #   if @picture.save
  #     if params[:commit] == "save picture & save monument"  #  if no more pictures should be added TO DO: find better solution
  #       @monument = Monument.find(@picture.monument_id)
  #       @monument.update(step: 2)  # jump to the next step
  #     end
  #     redirect_to edit_monument_path(id: @picture.monument_id), notice: 'You succesfully uploaded a picture.'
  #   else # some validation is missing
  #     @monument = Monument.find(@picture.monument_id)
  #     @monument.step = 2 # for rendering
  #     render 'monuments/edit'
  #   end
  # end
  
  # def index
  #   @pictures = current_user.pictures
  # end
  
  # def new
  #   @picture = Picture.new(monument_id: params[:monument_id)
  # end
  
  # def create
  #   @picture = Picture.new(picture_params)
  #   if @picture.save
  #     redirect_to pictures_path, notice: 'You created succesfully a picture.'
  #   else
  #     render action: 'new'
  #   end
  # end
  
  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to monument_path(@picture.monument_id), notice: 'You updated your picture successfully.'
    else
      render action: 'edit'
    end
  end
  
  # def show
  # end
  
  def destroy
    @picture.destroy
    if @picture.monument.step == 3 # not in edit
      redirect_to monument_path(@picture.monument_id)
    else
      if @picture.monument.pictures.count == 0  # should have at least one picture
        redirect_to edit_step_monument_path(@picture.monument_id, step: 2)
      else
        redirect_to edit_step_monument_path(@picture.monument_id, step: 3)
      end
    end
      
  end
  
  private
  
  def find_picture
    @picture = Picture.find(params[:id])
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:file, :name, :date, :description, :monument_id)
  end
  
  
end
