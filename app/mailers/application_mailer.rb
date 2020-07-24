class ApplicationMailer < ActionMailer::Base
  # メールの差し出しもと
  default from: 'from@example.com'
  layout 'mailer'

end
