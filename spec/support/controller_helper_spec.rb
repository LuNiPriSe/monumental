# for simple authetication tests

module ControllerHelpers
   def sign_in(user = double('user', id: 1))
      allow(user).to receive(:collections).and_return(Collection.all)   # bad hack because no user_id checked
     if user.nil?
       allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
       allow(controller).to receive(:current_user).and_return(nil)
     else
       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
       allow(controller).to receive(:current_user).and_return(user)
     end
   end
   
   # def sign_in_as_admin(user = double('user', admin: true))
   #    allow(user).to receive(:collections).and_return(true)
   #    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
   #    allow(controller).to receive(:current_user).and_return(user)
   #  end
 end

 RSpec.configure do |config|
   config.include Devise::TestHelpers, :type => :controller
   config.include ControllerHelpers, :type => :controller
 end