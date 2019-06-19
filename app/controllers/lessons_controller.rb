class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_current_section


  #def show
   # @lesson = current_lesson.section.course(lesson_params)
   # redirect_to instructor_course_path(current_lesson.section.course)
  #end


  private

    
  def require_enrollment_for_current_course
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: "Kindly enroll to view course!"
    end

  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
end