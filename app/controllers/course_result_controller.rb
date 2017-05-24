class CourseResultController < ApplicationController
  def current
    render json: CourseResult.where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))
  end

  def history
    render json: CourseResult.last(10).reverse
  end
end
