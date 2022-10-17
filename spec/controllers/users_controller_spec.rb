require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:user1) { FactoryBot.create :user }
  let(:user2) { FactoryBot.create :user }
  let(:department) { FactoryBot.create :department }
  let!(:user_department) {
    FactoryBot.create :user_department,
    user_id: user.id,
    department_id: department.id,
    role: 1
  }
  before do
    sign_in user
  end

  describe "GET#new" do
    it "should render a template " do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST#create" do
    context "when create is successful" do
      before do
        post :create, params: {
          user: {
            email: "test@example.com",
            password: "123456",
            password_confirmation: "123456"
          }
        }
      end
      it "should redirect to rooth path" do
        expect(response).to redirect_to root_path
      end
    end
    context "when create is failure" do
      before do
        post :create, params: {
          user: {
            email: "test.com",
            password: "123456",
            password_confirmation: "123458"
          }
        }
      end
      it "should redirect to rooth path" do
        expect(response).to render_template("new")
      end
    end
  end
  describe "PATCH#update" do
    context "when update user is successful" do
      before do
        patch :update, xhr: true, params: {
          id: user.id,
          user: {name: "Hello"}
        }
      end
      it "should redirect to rooth path" do
        expect(response).to redirect_to root_path
      end
    end
    context "when update user is failed" do
      before do
        patch :update, xhr: true, params: {
          id: user.id,
          user: {email: "hello"}
        }
      end
      it "should render edit again" do
        expect(response).to render_template("edit")
      end
    end
  end
end
