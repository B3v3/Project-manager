class ProjectMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_mailer.project_invite.subject
  #
  def project_invite(project, mail)
    @project = project
    mail to: mail, subject: 'Invite to new project!'
  end
end
