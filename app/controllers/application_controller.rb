class ApplicationController < ActionController::Base
  protect_from_forgery

  def owns_trip
    if !user_signed_in? || current_user != Trip.find(params[:id]).user
      redirect_to trips_path, error: "You cannot do that"
    end
  end
end
