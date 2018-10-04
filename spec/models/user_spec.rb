require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  describe 'validations' do
    it "should accept a valid user" do
      expect(user.valid?).to be_truthy
    end

    describe 'name' do
      it "should exists" do
        user.name = ''
        expect(user.valid?).to be_falsey
      end
      it "should be longer than 2 characters" do
        user.name = 'aa'
        expect(user.valid?).to be_falsey
      end
      it "should be shorter than 26 characters" do
        user.name = 'a'*26
        expect(user.valid?).to be_falsey
      end
      it "should be unique" do
        user.save
        user1 = build(:user, email: 'agitejszyn@informejszyn.pup')
        expect(user1.valid?).to be_falsey
      end
    end

    describe 'email' do
      it "should exists" do
        user.email = ''
        expect(user.valid?).to be_falsey
      end
      it "should be shorter than 200 characters" do
        user.email = "#{'a'*195}@uga.buga"
        expect(user.valid?).to be_falsey
      end
      it "should be unique" do
        user.save
        user1 = build(:user, name: 'dajciemiprace')
        expect(user1.valid?).to be_falsey
      end
      it "should be a valid email" do
        user.email = 'dajciemiwygodnyfotel'
        expect(user.valid?).to be_falsey
      end
    end

    describe 'password' do
      it "should exists" do
        user.password = ''
        expect(user.valid?).to be_falsey
      end
      it "should have a confirmation" do
        user.password_confirmation = ''
        expect(user.valid?).to be_falsey
      end
      it "should have a same confirmation" do
        user.password_confirmation = 'siemaneczko'
        expect(user.valid?).to be_falsey
      end
      it "should be longer than 5 characters" do
        user.password = 'aaaa'
        user.password_confirmation = 'aaaa'
        expect(user.valid?).to be_falsey
      end
    end
    describe 'relationships' do
      before(:each) do
        user.save
        create(:project)
      end

      it "should own a project" do
        expect(user.projects).to include(Project.first)
      end
      it 'should own a task' do
        task = create(:task)
        task.assign_user(user)
        expect(user.tasks).to include(task)
      end
      it "should unassign for task after delete" do
        task = create(:task)
        user1 = create(:user1)
        task.assign_user(user1)
        expect(user1.tasks).to include(task)
        user1.destroy
        expect(task.user).to be_nil
      end
      it "should delete projects after delete" do
        expect{ user.destroy}.to change(Project, :count).by(-1)
      end
      it "should can join a project" do
        create(:user1)
        project_new = create(:project, title: 'laoavae', user_id: 2 )
        project_new.add_member(user)
        expect(user.groups).to include(Project.first, project_new)
      end
    end
  end
end
