
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #index" do
        it "returns a success response" do
            get :index
            expect(response).to be_successful
        end

        it "assigns @users" do
            user1=User.create(name:"John", email:"john@example.com", password:"password", password_confirmation:"password",role:0)
            user2=User.create(name:"Jack", email:"jack@example.com", password:"password", password_confirmation:"password",role:0)
            
            # Deleting one user(Test User) which is created while testing user model
            User.where.not(id: [user1.id, user2.id]).delete_all

            get :index
            expect(assigns(:users)).to eq([user1,user2])
        end
    end

    describe "GET #new" do
        it "returns a success response" do
          get :new
          expect(response).to be_successful
        end
    end

    describe "POST #create" do
        context "with valid parameters" do
            it "creates a new User" do
                expect {
                post :create, params: { user: { name: "Test User", email: "test1@example.com", password: "password", password_confirmation: "password"}}
                }.to change(User, :count).by(1)
            end

            it "redirects to the login page" do
                post :create, params: {user: { name: "Test User", email: "test1@example.com", password: "password", password_confirmation: "password"}}
                expect(response).to redirect_to (root_path)
            end
        end

        context "with invalid parameters" do
            it "returns a success response (i.e. to display the 'new' template)" do
                post :create, params: { user: { name: nil, email: nil, password: nil, password_confirmation: nil } }
                expect(response).to be_successful
            end
        end
    end

    describe "DELETE #destroy" do
        

        context "when user is logged in" do
          it "destroys the user" do
            user=User.create(name: "Test User", email: "test1@example.com", password: "password", password_confirmation: "password",role:1)
            expect {
              delete :destroy, params: { id: user.id }
            }.to change(User, :count).by(-1)
          end
    
        #   it "redirects to the root page" do
        #     delete :destroy, params: { id: user.id }
        #     expect(response).to redirect_to root_path
        #   end
        end
    
        # context "when user is not logged in" do
        #   it "redirects to the login page" do
        #     delete :destroy, params: { id: user.id }
        #     expect(response).to redirect_to new_user_session_path
        #   end
        # end
    end

end
