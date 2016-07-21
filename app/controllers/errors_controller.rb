class ErrorsController < ApplicationController
  def not_found
    render(status: 404)
  end

  def validation_error
    render(status: 422)
  end
end
