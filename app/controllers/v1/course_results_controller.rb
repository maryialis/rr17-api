module V1
  class CourseResultsController < ApiBaseController
    def current
      render json: CourseResult.where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))
    end

    def history
      render json: CourseResult.order(created_at: :desc).limit(10)
    end
  end
end
