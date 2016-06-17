class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_language

  def current_user
    return unless session[:user]
    User.find(session[:user])
  end

  def set_language
    return unless params[:lang]
    language = params[:lang] || 'en'
    I18n.locale = language
  end
end
