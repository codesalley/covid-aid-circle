class HomeController < ApplicationController 
    before_action :authenticate_user!

def index 
    @logData  = []
    User.all.map do |user|  
        if user.current_sign_in_ip.size > 5 
            results = Geocoder.search(user.current_sign_in_ip)
            @logData << JSON.generate( { 
                        lat: results.first.coordinates[0], 
                        lng:  results.first.coordinates[1], 
                        donor: user.donor,
                        user: user.username,
                    } )
        end
    end
    
    
end

end