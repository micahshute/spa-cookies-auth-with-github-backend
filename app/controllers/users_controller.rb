class UsersController < ApplicationController


    def create
        # binding.pry
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            cookies["logged_in"] = true
            render json: user, except: [:password_digest]
        else
            render json: { errors: user.errors.full_messages}
        end
    end


    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
