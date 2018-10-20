require_relative 'project'

class ProjectSet
  def initialize(project_list)
    @projects = project_list
  end

  def duration
    (start_date..end_date)
  end

  def start_date
    @projects.min_by {|project| project.start_date }.start_date
  end

  def end_date
    @projects.max_by {|project| project.end_date }.end_date
  end
end
