class ApplicationController < ActionController::Base                                         
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # def current_billings
#     @current_billings = Billing.current
#   end
#
#   helper_method :current_billings
end
