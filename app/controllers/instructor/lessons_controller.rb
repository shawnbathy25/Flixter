class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end
  

  private
    def require_enrollment_for_current_course
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: "You are not enrolled!"
    end
  end

     helper_method :current_section
   def current_section
    @current_section ||= Section.find(params[:section_id])
  end

   

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
end
