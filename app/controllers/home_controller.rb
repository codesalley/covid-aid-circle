class HomeController < ApplicationController 
    before_action :authenticate_user!

def index 
    results = Geocoder.search(current_user.current_sign_in_ip)
    @logLan = results[0].data['loc'].split(',') unless results.empty?
end

end