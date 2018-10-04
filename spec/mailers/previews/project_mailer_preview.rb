# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/project_mailer/project_invite
  def project_invite
    ProjectMailer.project_invite(Project.last, User.first.email)
  end

end
