require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) {build(:task)}

  before(:each) do
    create(:user)
    create(:project)
  end

  describe 'validations' do
    it "should accept a valid task" do
      expect(task.valid?).to be_truthy
    end
    describe 'description' do
      it 'should exists' do
        task.description = ""
        expect(task.valid?).to be_falsey
      end
      it "should be longer than 2 characters" do
        task.description = "aa"
        expect(task.valid?).to be_falsey
      end
      it "should be shorter than 151 characters" do
        task.description = "a"*151
        expect(task.valid?).to be_falsey
      end
    end

    describe 'status' do
      it "should have false status at start" do
        expect(task.status).to be_falsey
      end
      it "should have true status after complete" do
        task.save
        task.complete
        expect(task.status).to be_truthy
      end
      it "should return status at #not_done? and #done?" do
        task.save
        expect(task.not_done?).to be_truthy
        expect(task.done?).to be_falsey
        task.complete
        expect(task.not_done?).to be_falsey
        expect(task.done?).to be_truthy
      end
    end

    describe 'status?' do
      it "should return valid message at each stage" do
        task.save
        expect(task.status?).to eql('User not assigned!')
        task.assign_user(User.first)
        expect(task.status?).to eql('In progress!')
        task.complete
        expect(task.status?).to eql('Done!')
      end
    end

    describe 'relationships' do
      it "should belongs to project" do
        task.project_id = ''
        expect(task.valid?).to be_falsey
      end
      it "should have relationship with project" do
        expect(task.project).to eql(Project.first)
      end
      it "should can delete and create relationship with user" do
        task.save
        expect(task.user_assigned?).to be_falsey
        task.assign_user(User.first)
        expect(task.user_assigned?).to be_truthy
        expect(task.user).to eql(User.first)
        task.unassign_user
        expect(task.user).to eql(nil)
      end
    end
  end
end
