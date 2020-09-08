class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: 404, status: false
  end

  def authenticate_user!
    return if logged_in?
    flash[:danger] = t "login_first"
    redirect_to login_path
  end

  def authenticate_supervisor!
    return if current_user&.supervisor?
    flash[:danger] = t "role"
    redirect_to current_user
  end

  def load_subjects_in_course
    @subjects = @course.subjects
  end

  def load_tasks_in_subject
    @tasks = @subject.tasks
  end

  def load_supervisors_in_course
    @supervisors = UserCourse.get_users_in_course_with_role @course.id, User.supervisor
  end

  def load_trainees_in_course
    @trainees = UserCourse.get_users_in_course_with_role @course.id, User.trainee
  end

  def load_finished_courses_of_user
    @finished_courses = UserCourse.get_courses_of_user_with_finished(@user.id,
      Settings.course.finished)
  end

  def load_unfinished_courses_of_user
    @unfinished_courses = UserCourse.get_courses_of_user_with_finished(@user.id,
      Settings.course.unfinished)
  end
end
