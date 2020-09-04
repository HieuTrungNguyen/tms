class CoursesController < ApplicationController
  before_action :authenticate_user!, :authenticate_supervisor!, except: %i(index show)
  before_action :load_course, except: %i(index new create add_member add_subject)
  before_action :load_course_to_add_object, only: %i(add_member add_subject)
  before_action :load_subjects_in_course, :load_supervisors_in_course,
    :load_trainees_in_course, only: :show

  def index
    @courses = Course.all.order_desc.page(params[:page]).per 10
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "flash.courses.add_course", name: @course.name
      redirect_to @course
    else
      flash.now[:danger] = t "flash.courses.add_fail"
      render :new
    end
  end

  def show; end

  def edit_profile
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "flash.courses.update_course", name: @course.name
    else
      flash[:danger] = t "try_again"
    end
    redirect_to @course
  end

  def destroy
    if @course.destroy
      flash[:success] = t "flash.courses.delete_course", name: @course.name
    else
      flash[:danger] = t "try_again"
    end
    redirect_to courses_path
  end

  def member_remaining
    @remain_users = User.get_users_not_exist_in_course(@course.id)
    respond_to :js
  end

  def add_member
    users_id = params[:usersChecked]
    begin
      UserCourse.transaction do
        users_id.each do |user_id|
          UserCourse.create! user_id: user_id.to_i,
                             course_id: @course.id.to_i,
                             status: :active,
                             date_join: Time.now
          load_supervisors_in_course
          load_trainees_in_course
        end
      end
    rescue => e
      respond_to do |format|
        format.json{render json: {status: 403}}
      end
    end
    respond_to :js
  end

  def subject_remaining
    @remain_subjects = Subject.get_subjects_not_exist_in_course(@course.id)
    respond_to :js
  end

  def add_subject
    subjects_id = params[:subjectsChecked]
    begin
      CourseSubject.transaction do
        subjects_id.each do |subject_id|
          CourseSubject.create! course_id: @course.id,
                                subject_id: subject_id.to_i

        end
        load_subjects_in_course
      end
    rescue => e
      respond_to do |format|
        format.json{render json: {status: 403}}
      end
    end
    respond_to :js
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :time_training, :cover
  end

  def load_course
    @course = Course.find_by id: params[:id]
    redirect_to courses_path unless @course
  end

  def load_course_to_add_object
    course_id = params[:courseId]
    @course = Course.find_by id: course_id
    return if @course.present?
    respond_to do |format|
      format.json{render json: {status: 404}}
    end
  end
end
