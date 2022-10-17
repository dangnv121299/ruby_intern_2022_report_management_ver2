require 'rails_helper'
include SessionsHelper

RSpec.describe ReportsController, type: :controller do
  let!(:user){ FactoryBot.create :user }
  let!(:user_1){ FactoryBot.create :user }
  let!(:department){ FactoryBot.create :department }
  let!(:department_1){ FactoryBot.create :department }
  let(:report){
    FactoryBot.create :report, user_id: user.id, department_id: department.id
  }
  let(:report_1){
    FactoryBot.create :report, user_id: user_1.id, department_id: department_1.id
  }

  before do
    sign_in user
  end

  describe "GET#show" do
    it "should show the reports of this user" do
      get :show, params:{id: report.id}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET#new" do
    it "should popup a new report by current user" do
      get :new
      expect(assigns(:report)).to be_a_new(Report)
    end
  end

  describe "GET#create" do
    let!(:user_department){
      FactoryBot.create :user_department,
      user_id: user.id,
      department_id: department.id,
      role: 1
    }
    let!(:user_department_0){
      FactoryBot.create :user_department,
      user_id: user_1.id,
      department_id: department.id,
      role: 0
    }
    let!(:user_department_1){
      FactoryBot.create :user_department,
      user_id: user.id,
      department_id: department_1.id,
      role: 0
    }
    let!(:user_department_2){
      FactoryBot.create :user_department,
      user_id: user_1.id,
      department_id: department_1.id,
      role: 1
    }
    context "when create and save a new report success full" do
      before do
        post :create, xhr: true, params: {
          report: {plan_today: "Today", reality: "reality", plan_next_day: "next day", department_id: department_1.id}
        }
      end
    end

    context "when create and save a new report failure" do
      before do
        post :create, xhr: true, params: {
          report: {plan_today: FFaker::Lorem.sentence(word_count = 40)}
        }
      end
      it "should display a danger flash" do
        expect(flash.now[:danger]).to eq I18n.t("reports.create.create_fail")
      end
    end
  end

  describe "GET#edit" do
    context "when cannot find a report" do
      before do
        get :edit, xhr:true, params:{
          id: -11
        }
      end

      it "should popup a flash message" do
        expect(flash[:danger]).to eq I18n.t("reports.edit.find_report")
      end
    end

    context "when the report is finded" do
      context "when the editer is the owner of the report" do
        before do
          get :edit, xhr: true, params:{
            id: report.id
          }
        end

        it "should show edit form" do
          expect(response).to render_template("form")
        end
      end

      context "when the editer is the manager of the report" do
        before do
          get :edit, xhr: true, params:{
          id: report_1.id
          }
        end

        it "should show edit form" do
        end
      end
    end
  end

  describe "GET#update" do
    context "when editer is the owner of the report" do
      context "when update success" do
        before do
          patch :update, xhr: true, params: {
            id: report.id,
            report: {plan_today: "update", reality: "reality", plan_next_day: "next day"},
          }
        end
      end
      context "when update failure" do
        before do
          patch :update, xhr: true, params: {
            id: report.id,
            report: {plan_today: ""},
          }
        end

        it "should popup a flash message" do
          expect(flash.now[:danger]).to eq I18n.t("reports.update.update_fail")
        end

        it "should render a edit again" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when the editer is the manager" do
      before do
        patch :update, xhr: true, params: {
          id: report_1.id,
          report: {status: "approved"},
        }
      end

      it "should update the report" do
      end
    end
  end
end
