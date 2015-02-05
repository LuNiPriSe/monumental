class MonumentsController < ApplicationController
  before_filter :find_monument, :only => [:show, :update, :destroy, :finish, :change_public_state, :change_aproval_state]
  
  def index
    @monuments = current_user.monuments.order(created_at: :desc)  #TO DO just the ones from the user
  end
  
  def new
    if params[:id] and params[:step]
      prepare_step
    else
      @monument = Monument.new(step: 1, collection_id: params[:collection_id])
    end
  end
  
  def create
    @monument = Monument.new(monument_params)
    if @monument.save
      redirect_to new_step_monument_path(id: @monument.id, step: @monument.step + 1)
    else
      render action: 'new'
    end
  end

  def edit
    prepare_step
  end
  
  def update
    if @monument.update(monument_params)
      redirect_to edit_step_monument_path(id: @monument.id, step: @monument.step + 1)
    else
      render action: 'edit'
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
    if params[:last_action] == "new"
      redirect_to new_step_monument_path(id: @picture.monument_id, step: step), notice: 'You succesfully uploaded a picture.'  
    else
      redirect_to edit_step_monument_path(id: @picture.monument_id, step: step), notice: 'You succesfully uploaded a picture.'
    end
    else # some validation is failing => can't redirect or loose messages
      @monument = Monument.find(@picture.monument_id)
      if params[:last_action] == "new"
        @monument.step = 2 # for rendering
        url = 'monuments/new'
      else
        params[:step] = '2' # for rendering 
        url = 'monuments/edit'
      end
      @last_action = params[:last_action]
      render url
    end
  end
  
  def finish
    if @monument.update(step: 3)
      redirect_to @monument, notice: 'Your monument has sucesfully been created.'
    else
      render action: 'edit'
    end
  end
  
  def change_public_state
    if @monument.public == true
      @monument.update(public: false)
    else
      @monument.update(public: true)
    end
    redirect_to :back
  end
  
  def change_aproval_state
    if @monument.public_aproved == true
      @monument.update(public_aproved: false)
    else
      @monument.update(public_aproved: true)
    end
    redirect_to :back
  end
  
  private

  def prepare_step
    find_monument
    @last_action = action_name # save action for form2
    @monument.step = params[:step]
    @picture = Picture.new(monument_id: @monument.id) if @monument.step == 2 # in order to create new picture
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
