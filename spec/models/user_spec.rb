require 'rails_helper'

RSpec.describe User, type: :model do
    describe "validations" do
        it "is valid with a name, email, password and role" do
            user = User.new(
                name: "Test User",
                email: "test2@example.com",
                password: "password",
                role: 0
            )
            expect(user).to be_valid
        end

        it "is invalid without name" do
            user = User.new(
                name: nil,
                email: "test2@example.com",
                password: "password",
                role: 0
            )
            user.valid?
            expect(user.errors[:name]).to include("can't be blank")
        end

        it "is invalid without email" do
            user=User.new(
                name: "Another Test User1",
                email: nil,
                password: "user1@123",
                role: 0
            )
            user.valid?
            expect(user.errors[:email]).to include("can't be blank")
        end

        it "is invalid with duplicate email" do
            User.create(
                name: "Test User1",
                email: "user1@gmail.com",
                password: "user1@123",
                role: 0
            )
            user=User.new(
                name: "Another Test User1",
                email: "user1@gmail.com",
                password: "user1@123",
                role: 0
            )
            user.valid?
            expect(user.errors[:email]).to include("has already been taken")
        end

        it "is invalid without password" do
            user=User.new(
                name: "Another Test User1",
                email: "user!@gmail.com",
                password: nil,
                role: 0
            )
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
        end

        it "is invalid with non-matching password" do
            user=User.new(
                name: "Test User",
                email: "user@gmail.com",
                password: "password",
                password_confirmation: "wrongpassword",
                role: 0
            )
            user.valid?
            expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        end
        
        it "is invalid with password having less than 5 characters" do 
            user=User.new(
                name: "Test User",
                email: "user@gmail.com",
                password: "pass",
                role: 0
            )
            user.valid?
            expect(user.errors[:password]).to include("is too short (minimum is 5 characters)")
        end

        it "is invalid without role" do
            user=User.new(
                name: "Test User",
                email: "user@gmail.com",
                password: "password",
                role: nil
            )
            user.valid?
            expect(user.errors[:role]).to include("can't be blank")
        end

        
    end

    after(:each) do
        User.destroy_all
    end
end
    