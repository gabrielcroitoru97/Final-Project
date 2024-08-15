class WorkLocationsController < ApplicationController
  def index
    matching_work_locations = WorkLocation.all

    @list_of_work_locations = matching_work_locations.order({ :created_at => :desc })

    render({ :template => "work_locations/index" })
  end


  def show
    the_id = params.fetch("path_id")

    matching_work_locations = WorkLocation.where({ :id => the_id })

    @the_work_location = matching_work_locations.at(0)
    @ratings=Rating.where({:location_id=>the_id})

    render({ :template => "work_locations/show" })
  end

  def new_page
    @loc_types = LocationType.all

    render({ :template => "work_locations/new_page" })

  end



  def create
    the_work_location = WorkLocation.new
    the_work_location.location_type_id = params.fetch("query_location_type")
    the_work_location.wifi_speed =Rating.where({:location_id =>the_work_location.id}).average(:wifi_rating)
    the_work_location.address = params.fetch("query_address")
    the_work_location.weekday_opening = params.fetch("query_weekday_opening")
    the_work_location.weekend_opening = params.fetch("query_weekend_opening")
    the_work_location.weekday_closing = params.fetch("query_weekday_closing")
    the_work_location.weekend_closing = params.fetch("query_weekend_closing")
    the_work_location.phone_number = params.fetch("query_phone_number")
    the_work_location.website = params.fetch("query_website")
    the_work_location.city = params.fetch("query_city")
    the_work_location.state = params.fetch("query_state")
    the_work_location.zip_code = params.fetch("query_zip_code")
    the_work_location.description = params.fetch("query_description")
    the_work_location.name = params.fetch("query_name")
    the_work_location.average_rating  = Rating.where({:location_id =>the_work_location.id}).average(:stars)
    the_work_location.owner_id = current_user.id
    the_work_location.crowding_average =Rating.where({:location_id =>the_work_location.id}).average(:crowding_score)
    the_work_location.noise_average  =Rating.where({:location_id =>the_work_location.id}).average(:noise_level)
    the_work_location.requires_purchase = params.fetch("query_requires_purchase", false)
    the_work_location.membership = params.fetch("query_membership", false)

    if the_work_location.valid?
      the_work_location.save
      redirect_to("/work_locations/#{the_work_location.id}", { :notice => "Work location created successfully." })
    else
      redirect_to("/work_locations", { :alert => the_work_location.errors.full_messages.to_sentence })
    end
  end

  def edit
    the_id = params.fetch("path_id")
    @the_work_location=WorkLocation.where({:id=>the_id}).at(0)
    @loc_types = LocationType.all
    render({ :template => "work_locations/edit" })
  end

  def update
    the_id = params.fetch("path_id")
    the_work_location = WorkLocation.where({ :id => the_id }).at(0)

    the_work_location.location_type_id = params.fetch("query_location_type_id")
    the_work_location.address = params.fetch("query_address")
    the_work_location.weekday_opening = params.fetch("query_weekday_opening")
    the_work_location.weekend_opening = params.fetch("query_weekend_opening")
    the_work_location.weekday_closing = params.fetch("query_weekday_closing")
    the_work_location.weekend_closing = params.fetch("query_weekend_closing")
    the_work_location.phone_number = params.fetch("query_phone_number")
    the_work_location.website = params.fetch("query_website")
    the_work_location.city = params.fetch("query_city")
    the_work_location.state = params.fetch("query_state")
    the_work_location.zip_code = params.fetch("query_zip_code")
    the_work_location.description = params.fetch("query_description")
    the_work_location.name = params.fetch("query_name")
    the_work_location.requires_purchase = params.fetch("query_requires_purchase", false)
    the_work_location.membership = params.fetch("query_membership", false)

    if the_work_location.valid?
      the_work_location.save
      redirect_to("/work_locations/#{the_work_location.id}", { :notice => "Work location updated successfully."} )
    else
      redirect_to("/work_locations/#{the_work_location.id}", { :alert => the_work_location.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_work_location = WorkLocation.where({ :id => the_id }).at(0)

    the_work_location.destroy

    redirect_to("/work_locations", { :notice => "Work location deleted successfully."} )
  end
end
