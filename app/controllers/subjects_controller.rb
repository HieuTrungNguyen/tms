class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_supervisor!, only: %i(index)
  before_action :load_subject, only: %i(show)
  before_action :load_tasks_in_subject, only: %i(show)

  def index
    @subjects = Subject.newest.page(params[:page]).per 9
  end

  def show; end

  private
  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?
    flash[:danger] = t "flash.subjects.not_find"
    redirect_to subjects_path
  end
end
