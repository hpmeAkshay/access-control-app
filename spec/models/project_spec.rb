require 'rails_helper'

RSpec.describe Project, type: :model do
    describe "validations " do
        it "is valid with name and desciption" do
            project=Project.new(
                name:"Test project",
                description: "Test project description",
                user_id: 1
            )
            expect(project).to be_valid
        end

        it "is invalid without name" do
            project=Project.new(
                name: nil,
                description: "Test project description",
                user_id: 1
            )
            project.valid?
            expect(project.errors[:name]).to include("can't be blank")
        end

        it "is invalid with name having less than 2 characters" do 
            project=Project.new(
                name: "T",
                description: "Test project description",
                user_id: 1
            )
            project.valid?
            expect(project.errors[:name]).to include("is too short (minimum is 2 characters)")
        end

        it "is invalid without description" do
            project=Project.new(
                name: "Test project",
                description: nil,
                user_id: 1
            )
            project.valid?
            expect(project.errors[:description]).to include("can't be blank")
        end

        it "is invalid without user_id" do
            project=Project.new(
                name: "Test project",
                description: "Test project description",
                user_id: nil
            )
            project.valid?
            expect(project.errors[:user_id]).to include("can't be blank")
        end
    end
end