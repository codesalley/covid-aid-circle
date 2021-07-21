class HomeController < ApplicationController 
   before_action :authenticate_user 

    def index 
        @logData  = []
        User.all.map do |user|  
            if user.codinates.size > 0 
                
               
                @logData << JSON.generate( { 
                            lat: user.codinates[0], 
                            lng:  user.codinates[1], 
                            donor: user.donor,
                            user: user.first_name + " " +  user.last_name,
                        } ) unless user.codinates.nil?
            end
        end
    end

    def user_profile
      @donations = current_user.donations
      p  @donations
  
    end


end