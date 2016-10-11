
#require 'mailgun'
class ExampleMailer < ActionMailer::Base
default from: "krishna.nbk@gmail.com"

  def sample_email(description)
  	@description = description
  	@users=User.all
  	@users.each do |user|
    mail(to: user.email, subject: 'Reminder Email')
	end
  end
end
