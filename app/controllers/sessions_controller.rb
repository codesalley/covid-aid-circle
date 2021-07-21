class SessionsController < ApplicationController 
    
    before_action :authenticate_user, only: [:welome, :verify_code]

    def signup
        @user = User.new
    end
    def new_session 
        user = User.create(user_params)
        p user 
        if user.save
            session[:user_id] = user.id
            ip =  request.location
            results = Geocoder.search(ip)
            user.codinates = results.first.coordinates
            redirect_to welcome_path, notice: 'welcome, verify account to get connected'
        else
          render  :signup
        end
    end
    def welcome 
    end
    def verify_code
         if current_user.tmp_code === params[:confirmation_code]
            current_user.update(activated: true)
            redirect_to root_path
         else
            flash[:alert] = 'invalid code'
            render :welcome
         end
        
    end

    private 
    def user_params 
        params.require(:user).permit(:first_name, :last_name, :middle_name, :address, :phone_number, :password, :password_confirmation, :donor)
    end
end