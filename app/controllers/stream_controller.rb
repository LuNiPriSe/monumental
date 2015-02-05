class StreamController < ApplicationController
  
  def index
    @monuments = Monument.where(public: true, public_aproved: true).order(created_at: :asc)
  end
  
  def aprove
    if current_user.admin == true
      @monuments = Monument.where(public: true).order(public_aproved: :asc, created_at: :asc)
    else
      redirect_to monuments_stream_path
    end
  end
  
end
