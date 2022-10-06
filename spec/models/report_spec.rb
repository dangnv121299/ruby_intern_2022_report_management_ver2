require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:user){
    FactoryBot.create :user
  }
  let(:user_1){
    FactoryBot.create :user
  }
  
  let(:user_2){
    FactoryBot.create :user
  }
  let(:department){
    FactoryBot.create :department
  }

  let(:department_1){
    FactoryBot.create :department
  }

  let(:department_2){
    FactoryBot.create :department
  }
  let(:report){
    FactoryBot.create :report
  }

  let(:report_1){
    FactoryBot.create :report, user_id: user_1.id, department_id: department_1.id
  }

  let(:report_2){
    FactoryBot.create :report, user_id: user_2.id, department_id: department_2.id
  }

  describe "presence" do
    it { is_expected.to validate_presence_of(:plan_today) }
    it { is_expected.to validate_presence_of(:reality) }
    it { is_expected.to validate_presence_of(:plan_next_day) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { should belong_to(:department).optional(true) }
    it { should belong_to(:user_department).optional(true) }
  end

  describe "Validations" do
    context "when field plan today" do
      subject{FactoryBot.build(:report)}
      it {should validate_presence_of(:plan_today)}
      it {is_expected.to validate_length_of(:plan_today).is_at_most(Settings.report.max_length)}
    end

    context "when field reality" do
      subject{FactoryBot.build(:report)}
      it {should validate_presence_of(:reality)}
      it {is_expected.to validate_length_of(:reality).is_at_most(Settings.report.max_length)}
    end

    context "when field plan next day" do
      subject{FactoryBot.build(:report)}
      it {should validate_presence_of(:plan_next_day)}
      it {is_expected.to validate_length_of(:plan_next_day).is_at_most(Settings.report.max_length)}
    end
  end

  describe "check scope" do
    context "orders by created_at descending" do
      it "Should order by created_at" do
        expect(Report.newest).not_to eq([report_1, report_2])
      end
    end

    context "report by department" do
      it "Should find by department" do
        expect(Report.search_department(department_1.id)).to eq([report_1])
      end
      it "Should find by department" do
        expect(Report.by_department_id(department_1.id)).to eq([report_1])
      end
    end

    context "report find by date" do
      it "should find by start date " do
        expect(Report.start(Date.yesterday)).to eq([report_1, report_2])
      end
      it "should find by end date " do
        expect(Report.end(Date.today)).to eq([report_1, report_2])
      end
    end
  end

  describe "search by params" do
    context "with params from user" do
      it "should find by status" do
        expect(Report.search({user_id: user_1.id, "department_id"=>"", "status"=>"1"})).to eq([report_1])
      end
    end
  end
end
