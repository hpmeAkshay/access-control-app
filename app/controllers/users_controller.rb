class UsersController < ApplicationController
    include SessionsHelper

    before_action :authorize_admin, only: [:edit, :update, :destroy]

    def new 
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        @user.role=0
        if @user.save
            log_in @user
            redirect_to root_url, notice: "User created successfully"
        else
            render 'new'
        end
    end

    def index
        @users=User.all
    end

    def edit 
        @user=User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        
        if @user.update(user_update_params)
            redirect_to users_path, notice: 'User was successfully updated.'
        else
            flash.now[:notice]="Unable to update User"
            render :edit
        end
    end

    def destroy
        @user=User.find(params[:id]);
        @user.destroy
        redirect_to users_path
    end

    def home 
    end

    
    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def user_update_params
        params.require(:user).permit(:role)
    end

    def forgot_password
        render :forgot_password
    end

    def reset_password
        user=User.find_by(email: params[:email])

        if user
            user.generate_password_token!
            UserMailer.reset_password_email(user).deliver_now
            flash[:notice]="An email has been sent to #{params[:email]} with instructions to reset your password"
            redirect_to login_path
        else
            flash[:notice]="No user was found with email address #{params[:email]}."
            render :forgot_password
        end
    end

    def authorize_admin
        unless current_user.admin?
            flash[:notice]="Access Denied ! Please login as Admin"
            redirect_to users_path
        end
    end
end

