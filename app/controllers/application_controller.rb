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
    # this code will run only when params[:lang] exists
    if params[:lang]
      language = params[:lang]
      if session[:user]
        user = User.find session[:user]
        user.update(language: language)
        language = user.language
      end
      I18n.locale = session[:lang] = language
    else
      I18n.locale = session[:lang]
    end
  end
end
