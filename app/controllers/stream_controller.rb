class StreamController < ApplicationController
  
  def index
    if current_user.admin == true
      @monuments = Monument.where(public: true).order(public_aproved: :asc, created_at: :asc)
    else
      @monuments = Monument.where(public: true, public_aproved: true).order(created_at: :asc)
    end
  end
  
end
