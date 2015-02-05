class PicturesController < ApplicationController
  
  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      if params[:commit] == "save picture & save monument"  #  if no more pictures should be added TO DO: find better solution
        @monument = Monument.find(@picture.monument_id)
        @monument.update(step: 2)  # jump to the next step
      end
      redirect_to edit_monument_path(id: @picture.monument_id), notice: 'You succesfully uploaded a picture.'  
    else # some validation is missing
      @monument = Monument.find(@picture.monument_id)
      @monument.step = 2 # for rendering
      render 'monuments/edit'
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:file, :name, :date, :description, :monument_id)
  end
  
  
end
