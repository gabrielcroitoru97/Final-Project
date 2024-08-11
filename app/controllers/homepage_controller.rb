class HomepageController < ApplicationController
  
  def visit
    render({ :template => "work_locations/index" })
  end
end
