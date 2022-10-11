require 'rails_helper'
include SessionsHelper

RSpec.describe UserDepartmentsController, type: :controller do
  let(:admin) { FactoryBot.create :user, role: 2 }
  let(:user) { FactoryBot.create :user }
  let(:department) { FactoryBot.create :department }
  before do
    log_in admin
  end
end
