class ApplicationController < ActionController::Base
    # before_action :parse_json_to_params
    rescue_from AppError::AuthenticationError, with: :not_authorized
    # rescue_from ActionController::InvalidAuthenticityToken, with: :bad_csrf

    def home
        authenticate
        render json: {protected_content: "Hello World"}
    end


    protected

    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def authorize_resource(resource)
        raise AppError::AuthenticationError if !current_user || resource.user != current_user
    end

    def authenticate
        raise AppError::AuthenticationError if !logged_in?
    end

    def not_authorized
        render json: {error: "Not Authorized"}, status: 401
    end

    def bad_csrf
        binding.pry
        # csrf_token = request.headers["HTTP_X_CSRF_TOKEN"]
        # throw "Bad CSRF" unless valid_authenticity_token?(session, csrf_token)
    end

    # def parse_json_to_params
        
    #     if(request.content_type == 'application/json')
    #         params.merge! JSON.parse(request.body.read)
    #     end
    #     binding.pry
    # end


end
