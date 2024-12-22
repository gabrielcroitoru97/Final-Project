class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!  # Ensure the user is signed in
  before_action :require_admin      # Ensure the user is an admin

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied. Admins only."
    end
  end
end
