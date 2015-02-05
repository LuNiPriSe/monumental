class StreamController < ApplicationController
  
  def index
    if params[:search] 
      @monuments = Monument.public.search(params[:search])
    else
      @monuments = Monument.public
    end
  end
  
  def orbit    
    if params[:search] 
      @monuments = Monument.public.search(params[:search])
    else
      @monuments = Monument.public
    end
  end
  
  def aprove
    if current_user.admin == true
      @monuments = Monument.where(public: true).order(public_aproved: :asc, created_at: :asc)
    else
      redirect_to monuments_stream_path
    end
  end
  
end
