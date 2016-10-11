# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  description :string(255)
#  priority    :integer
#  deadline    :datetime
#  reminder    :datetime
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :deadline, :description, :priority, :reminder, :status

  after_initialize :init
  after_create :reminder_email

@@REMINDER_TIME = 30.minutes
  validates :priority, :inclusion => { :in => 1..5, :message => "The priority must be between 1 and 5" }, presence: true
  validates :status, :inclusion => { :in => 1..3, :message => "The status must be between 1 and 3" } , presence: true
  validates :description , presence: true
  validates :deadline , presence: true

  def init
  	self.status = 1
  end
   # before_save { deadline.to_datetime! ; reminder.to_datetime! }
def self.as_csv
  CSV.generate do |csv|
    csv << column_names
    all.each do |item|
      csv << item.attributes.values_at(*column_names)
    end
  end
end
def reminder_email
	ExampleMailer.sample_email(description).deliver
end

 def when_to_run
    reminder
  end

  handle_asynchronously :reminder_email , :run_at => Proc.new { |i| i.when_to_run }
end
