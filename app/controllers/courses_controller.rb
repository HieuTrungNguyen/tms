class CoursesController < ApplicationController
  before_action :authenticate_user!, :authenticate_supervisor!, except: %i(index show)
  before_action :load_course, except: %i(index new create)

  def index
    @courses = Course.all.order_desc.page(params[:page]).per 10
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t ".add_course", name: @course.name
      redirect_to @course
    else
      flash.now[:danger] = t ".add_fail"
      render :new
    end
  end

  def show
    @subjects = CourseSubject.get_subjects @course.id
  end

  def edit_profile
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      flash[:success] = t ".update_course", name: @course.name
    else
      flash[:danger] = t "try_again"
    end
    redirect_to @course
  end

  def destroy
    if @course.destroy
      flash[:success] = t ".delete_course", name: @course.name
    else
      flash[:danger] = t "try_again"
    end
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :time_training, :cover
  end

  def load_course
    @course = Course.find_by id: params[:id]
    redirect_to courses_path unless @course
  end
end
