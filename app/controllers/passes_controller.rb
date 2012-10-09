class PassesController < ApplicationController

  before_filter :authenticate_user!, :find_lesson
  before_filter :check_lesson_availability, only: %w(create buy)

  respond_to :json

  def create
    @lesson.create_enrollment(current_user)
    redirect_to lesson_path(@lesson)
  end

  def add_to_watchlist
    @lesson.create_subscription(current_user)
    respond_with true
  end

  private
    def find_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    def check_lesson_availability
      redirect_to lesson_path(@lesson) if !@lesson.available? || @lesson.user_already_applied?(current_user)
    end

end