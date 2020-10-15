class TasksController < ApplicationController
  before_action :load_subject

  def new; end

  def create
    @task = @subject.tasks.build task_params
    if @task.save
      load_tasks_in_subject
      respond_to :js
    else
      flash[:danger] = "Don't create new task at now. Try again!"
      redirect_to @subject
    end
  end

  private
  def task_params
    params.require(:task).permit :name, :description
  end

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
    return if @subject
    flash[:danger] = t "flash.subjects.not_find"
    redirect_to subjects_path
  end
end
