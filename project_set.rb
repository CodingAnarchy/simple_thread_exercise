require 'date'
require_relative 'project'

class ProjectSet
  attr_reader :projects, :reimbursement_values

  def initialize(project_list)
    @projects = project_list
    @reimbursement_values = duration.map{|date| [date, 0]}.to_h # Set up hash of date => value with all 0
  end

  def duration
    (start_date..end_date)
  end

  def reimbursement
    calculate_values
    @reimbursement_values.values.sum
  end

  private

  def project_for(date)
    @projects_by_date ||= {}
    @projects_by_date[date] ||= @projects.select{|project| project.on?(date) }.max_by{|project| project.full_cost } # Select projects on the given date and filter by higher cost if both exist
  end

  def start_date
    @projects.min_by {|project| project.start_date }.start_date
  end

  def end_date
    @projects.max_by {|project| project.end_date }.end_date
  end
  
  def calculate_values
    travel = true # First day of project sequence is a travel day
    duration.each do |date|
      if project_for(date).nil?
        travel = true # a gap sets travel back to true
        @reimbursement_values[date - 1] = project_for(date - 1).travel_cost if project_for(date - 1) # Set the preceding date to travel - it was the last day in project
      else # Not traveling - record this date
        if not (travel || date == end_date) or @projects.select{|project| project.on?(date) }.length > 1
          @reimbursement_values[date] = project_for(date).full_cost
        else
          @reimbursement_values[date] = project_for(date).travel_cost
        end
        travel = false
      end
    end
  end
end
