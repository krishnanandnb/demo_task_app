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

require 'spec_helper'

describe Task do
  before do
  	@task=Task.new(description: "very interesting task" , deadline: "25 May".to_datetime , reminder: "24 May".to_datetime ,status: 1 , priority: 1)
  end
  subject {@task}

    it { should respond_to(:description) }
  	it { should respond_to(:deadline) }
  	it { should respond_to(:reminder) }
  	it { should respond_to(:status)   }
  	it { should respond_to(:priority) }


   describe "valid instance" do
   	it {should be_valid}
   end

   describe "status more than 5 should be invalid" do
   	before { @task.status = 5}
   	it {should_not be_valid}
   end

   describe "status 3 should be valid (inclusive check)" do
   	before { @task.status = 3}
   	it {should be_valid}
   end

   describe "priority more than 5 should be invalid" do
   	before { @task.priority = 11}
   	it {should_not be_valid}
   end

   describe "description should be present" do
   	before { @task.description = ' '}
   	it {should_not be_valid}
   end

   describe "deadline should be present" do
   	before { @task.deadline = ' '}
   	it {should_not be_valid}
   end


end

