require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:membership) {build(:membership)}

  before(:each) do
    create(:user)
    create(:user1)
    create(:project)
  end

  describe 'validations'
    it "should accept a valid membership" do
      expect(membership.valid?).to be_truthy
    end

    it "should have member id" do
      membership.member_id = ''
      expect(membership.valid?).to be_falsey
    end
    it "should have project id" do
      membership.project_id = ''
      expect(membership.valid?).to be_falsey
    end
    it "should dont allow same member/project combinations" do
      membership.member_id = 1
      expect{membership.save}.to raise_error(ActiveRecord::RecordNotUnique)
    end
end
