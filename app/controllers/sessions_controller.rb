class SessionsController < ApplicationController
    include SessionsHelper

    def new
    end
    
    def create 
        user=User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            log_in user
            redirect_to home_path
        else
            flash.now[:notice] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url, notice: "You have successfully logged out."
    end
end
