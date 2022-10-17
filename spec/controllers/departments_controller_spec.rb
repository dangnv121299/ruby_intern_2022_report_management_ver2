require 'rails_helper'
include SessionsHelper

RSpec.describe DepartmentsController, type: :controller do
  let(:admin){ FactoryBot.create :user, role: 2}
  let(:user){ FactoryBot.create :user }
  let(:department){ FactoryBot.create :department}
  before do
    sign_in admin
  end

  describe "GET#new" do
    it "assign @departments" do
      get :new, xhr: true
      expect(response).to render_template("form")
    end
  end

  describe "POST#create" do
    context "when creating a new department successfully" do
      before do
        post :create, params: {
          department: {name: "New Department"}
        }
      end

      it "should redirect to this department" do
        expect(response).to redirect_to departments_url
      end
    end

    context "when creating a new department failure" do
      before do
        post :create, params: {
          department: {name: ""}
        }
      end

      it "should redirect to this department" do
        expect(response).to render_template("new")
      end
    end

  end

  describe "PATCH#update" do
    context "when the department is updated successfully" do
      before do
        patch :update, xhr: true, params: {
          id: department.id,
          department: {name: "Update"},
        }
      end
      it "should redirects to the department path" do
        expect(response).to redirect_to department_url(id: department.id)
      end
    end

    context "when the department is updated failure" do
      before do
        patch :update, xhr: true, params: {
          id: department.id,
          department: {name: ""},
        }
      end
      it "should redirects to the new path" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE#destroy" do
    context "when admin destroy successfully" do
      before do
        delete :destroy, params: {
          id: department.id,
        }
      end
      it "should redirect to department path" do
        expect(response).to redirect_to departments_url
      end
    end
  end
end
