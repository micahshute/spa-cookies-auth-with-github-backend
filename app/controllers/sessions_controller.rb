class SessionsController < ApplicationController


    def login
        # binding.pry
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            cookies["logged_in"] = true
            render json: user
        else
            render json: { error: "Invalid Authentication"}, status: 401
        end

    end

    def auth_check
        cookies["logged_in"] = logged_in?
        render json: {csrf_auth_token: form_authenticity_token}
    end



    def logout
        authenticate
        session.clear
    end

    def github_redirect
        redirect_to '/auth/github'
    end

    def github_callback
        user = User.find_or_create_by(github_uid: auth['uid']) do |u|
            u.email = auth['info']['email'] || auth['info']['name']
            u.password = 'badpassword'
        end
        session[:user_id] = user.id
        cookies[:logged_in] = true
        redirect_to 'http://localhost:8000'
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end
