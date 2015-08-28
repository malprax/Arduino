class ApplicationController < ActionController::Base
  
                                                                                
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_time_zone
  
  def current_billings
    @current_billings = Billing.current
  end
  
  private
                                                                                 
  def set_time_zone
    return yield unless (utc_offset = cookies['browser.tzoffset']).present?
      utc_offset = utc_offset.to_i
      gmt_offset = if utc_offset == 0 then nil elsif utc_offset > 0 then -utc_offset else "+#{-utc_offset}" end
      Time.use_zone("Etc/GMT#{gmt_offset}"){ yield }
    rescue ArgumentError
      yield
  end
  
  helper_method :current_billings
end
