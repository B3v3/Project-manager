require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) {build(:project)}

  before(:each) do
    create(:user)
  end

  describe 'validations' do
    it "should accept a valid project" do
      expect(project.valid?).to be_truthy
    end

    describe 'title' do
      it "should exists" do
        project.title = ""
        expect(project.valid?).to be_falsey
      end
      it "should be longer than 2 characters" do
        project.title = "aa"
        expect(project.valid?).to be_falsey
      end
      it "should be shorter than 151 characters" do
        project.title = "a"*151
        expect(project.valid?).to be_falsey
      end
      it "should be unique" do
        project.save
        project = build(:project)
        expect(project.valid?).to be_falsey
      end
    end

    describe 'description' do
      it "should exists" do
        project.description = ""
        expect(project.valid?).to be_falsey
      end
      it "should be longer than 2 characters" do
        project.description = "aa"
        expect(project.valid?).to be_falsey
      end
      it "should be shorter than 257 characters" do
        project.description = "a"*257
        expect(project.valid?).to be_falsey
      end

      it "should have invite digest after creation" do
        project.save
        expect(project.invite_digest.nil?).to be_falsey
      end
    end

  describe 'relationships' do
      it "should have a relationship with tasks" do
        project.save
        create(:task)
        expect(project.tasks).to include(Task.first)
      end
      it "should delete tasks after deleted" do
        project.save
        create(:task)
        expect{ project.destroy}.to change(Task, :count).by(-1)
      end
      it "should have a user id" do
        project.user_id = ''
        expect(project.valid?).to be_falsey
      end
      it "should belongs to author" do
        expect(project.author).to eql(User.first)
      end
      it "#is_author? should return true or false" do
        expect(project.is_author?(User.first)).to be_truthy
        user1 = create(:user1)
        expect(project.is_author?(User.last)).to be_falsey
      end
      it "should can operate memberships of users" do
        user1 = create(:user1)
        project.save
        project.add_member(user1)
        expect(project.members).to include(User.first, User.last)
        project.kick_member(user1)
        expect(project.members).to include(User.first)
      end
      it "should can't delete author from members" do
        project.save
        expect{ project.kick_member(project.author)}
        .to_not change(project, :members)
      end
      it "should have author as member when created" do
        project.save
        expect(project.members).to include(project.author)
      end
    end
  end
end
