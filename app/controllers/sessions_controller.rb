class SessionsController < ApplicationController 
    
    def signup
        @user = User.new
    end
    def new_session 
    end
end