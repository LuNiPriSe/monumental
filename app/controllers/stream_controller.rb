class StreamController < ApplicationController
  
  def index
    @monuments = Monument.where(public: true, public_aproved: true)
  end
  
end
