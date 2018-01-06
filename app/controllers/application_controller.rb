class ApplicationController < ActionController::API
  rescue_from 'ActionController::ParameterMissing', with: :render_error

  protected

    def render_error(error)
      render json: { error: error }, status: 400
    end
end
