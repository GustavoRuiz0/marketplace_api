require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.build(:user)}

  subject { user }

  it {should respond_to(:email)}
  it {should respond_to(:password)}

  describe 'When email is present' do 
    it {should be_valid}
  end

  describe 'When email is not present' do 
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    it { should validate_presence_of(:email)}
    it { should allow_value('email@domain.com').for(:email) }
  end
end
