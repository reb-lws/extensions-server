class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  after_action :allow_iframe

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

end
