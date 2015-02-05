class MonumentsController < ApplicationController
  before_filter :find_monument, :only => [:show, :update, :destroy]
  
  def index
    @monuments = Monument.all.order(created_at: :desc)  #TO DO just the ones from the user
  end
  
  def new
    if params[:id] and params[:step]
      find_monument
      @monument.step = params[:step]
      @picture = Picture.new(monument_id: @monument.id) if @monument.step == 2
    else
      @monument = Monument.new(step: 1, collection_id: params[:collection_id])
    end
  end
  
  def create
    @monument = Monument.new(monument_params)
    if @monument.save
      redirect_to next_step_monument_path(id: @monument.id, step: @monument.step + 1)
    else
      render action: 'new'
    end
  end
  
  # step 0 -> 1 => shows monument-details forms
  # step 1 -> 2 => shows add_picture forms
  # step 2 -> 3 => shows monument overview
  def edit
    prepare_step
  end
  
  def update
    if @monument.update(monument_params)
      if @monument.step != 3
        @monument.step += 1   # in DB is the actual step, here we need the step rails is supposed to render
        @picture = Picture.new(monument_id: @monument.id) if @monument.step == 2 # in order to create new picture
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
  
  def add_picture
    @picture = Picture.new(picture_params)
    if @picture.save
      step = 2 # for adding more pictures
      if params[:commit] == "add picture & continue"  #  if no more pictures should be added TO DO: find better solution
      step = 3 # to finish monument creation
      end
    redirect_to next_step_monument_path(id: @picture.monument_id, step: step), notice: 'You succesfully uploaded a picture.'  
    else # some validation is missing
      @monument = Monument.find(@picture.monument_id)
      @monument.step = 2 # for rendering
      render 'monuments/edit'
    end
  end
  
  private

  def prepare_step
    find_monument
    if params[:jump_step]  # for back to specific step at overview TO DO: find better solution
      @monument.step = params[:jump_step].to_i - 1
    end
    if @monument.step != 3  # if monument is in creation process
      @monument.step += 1   # in DB is the actual step, here we need the step rails is supposed to render
      @picture = Picture.new(monument_id: @monument.id) if @monument.step == 2 # in order to create new picture
    else # if monument was finished start again
      @monument.step = 0
    end
  end

  def monument_params
    params.require(:monument).permit(:collection_id, :name, :description, :public, :public_approved, :step)
  end
  
  def picture_params
    params.require(:picture).permit(:file, :name, :date, :description, :monument_id)
  end
  
  def find_monument
    @monument = Monument.find(params[:id])
  end
  
end
