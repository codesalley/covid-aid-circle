class SessionsController < ApplicationController 
    
    def signup
        @user = User.new
    end
    def new_session 
        user = User.create(user_params)
        p user 
        if user.save
            p 'saved'
            session[user_id] = user.id
            redirect_to registration_path
        else
          render  :signup
        end
    end

    private 
    def user_params 
        params.require(:user).permit(:first_name, :last_name, :middle_name, :address, :phone_number, :password, :password_confirmation, :donor)
    end
end