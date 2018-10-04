require "rails_helper"

RSpec.describe "Login", :type => :request do

  let(:project) {create(:project)}
  let(:task)    {create(:task)}

  before(:each) do
    @user = create(:user)
  end
  describe 'redirecting logged users' do
    before(:each) do
      sign_in @user
    end
    it "redirects from login page" do
      get '/users/sign_in'
      expect(response).to redirect_to(root_path)
    end
    it "redirects form signup page" do
      get '/users/sign_up'
      expect(response).to redirect_to(root_path)
    end
    it "redirects after post login" do
      post user_session_path, params: {email: @user.email, password: '12345'}
      expect(response).to redirect_to(root_path)
    end
    it "redirects after post signup" do
      post user_registration_path, params: {name: 'John',
                                            email: @user.email,
                                            password: '12345'}
      expect(response).to redirect_to(root_path)
    end
  end
  describe 'redirecting not logged users' do
    describe 'projects controller' do
      it "redirects from show action" do
        get project_path(project)
        expect(response).to redirect_to(root_path)
      end
      it "redirects from edit action" do
        get edit_project_path(project)
        expect(response).to redirect_to(root_path)
      end
      it "redirects from new action" do
        get new_project_path(project)
        expect(response).to redirect_to(root_path)
      end
      it "redirects from create action" do
        post projects_path, params: {project: attributes_for(:project)}
        expect(response).to redirect_to(root_path)
      end
      it "redirects from update action" do
        patch project_path(project), params: {project: attributes_for(:project)}
        expect(response).to redirect_to(root_path)
      end
      it "redirects from send_invite action" do
        post send_invite_project_path(project), params: {email: 'a@a.a'}
        expect(response).to redirect_to(root_path)
      end
      it "redirects from destroy action" do
        delete project_path(project)
        expect(response).to redirect_to(root_path)
      end
    end
    describe 'tasks controller' do
      before(:each) do
        project.save
      end

      it "redirects from create action" do
        post project_tasks_path(project), params: {task: attributes_for(:task)}
        expect(response).to redirect_to(root_path)
      end
      it "redirects from destroy action" do
        delete project_task_path(project, task)
        expect(response).to redirect_to(root_path)
      end
      it "redirects from update_user action" do
        patch update_user_project_task_path(project, task)
        expect(response).to redirect_to(root_path)
      end
      it "redirects from update_status action" do
        patch update_status_project_task_path(project, task)
        expect(response).to redirect_to(root_path)
      end
    end
    describe 'memberships controller' do
      it "redirects from create action" do
        post project_memberships_path(project)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
