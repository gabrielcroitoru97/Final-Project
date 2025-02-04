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
    the_work_location.name = params.fetch("query_name")
    the_work_location.address = params.fetch("query_address")
    the_work_location.city = params.fetch("query_city")
    the_work_location.state = params.fetch("query_state")
    the_work_location.zip_code = params.fetch("query_zip_code")
    the_work_location.description = params.fetch("query_description")
    
    # Set daily opening and closing times
    %w[monday tuesday wednesday thursday friday saturday sunday].each do |day|
      the_work_location.send("#{day}_opening=", params["query_#{day}_opening"])
      the_work_location.send("#{day}_closing=", params["query_#{day}_closing"])
    end
  
    # Sanitize phone number to remove non-numeric characters
    the_work_location.phone_number = params.fetch("query_phone_number", "").gsub(/[^0-9]/, '')
  
    the_work_location.website = params.fetch("query_website")
    the_work_location.requires_purchase = params.fetch("query_requires_purchase", "0") == "1"
    the_work_location.membership = params.fetch("query_membership", "0") == "1"
    the_work_location.owner_id = current_user.id
    
    # Validate and save
    if the_work_location.valid?
      the_work_location.save
      redirect_to("/work_locations/#{the_work_location.id}", notice: "Work location created successfully.")
    else
      redirect_to("/work_locations/new_page", alert: the_work_location.errors.full_messages.to_sentence)
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
  
    the_work_location.location_type_id = params.fetch("query_location_type")
    the_work_location.name = params.fetch("query_name")
    the_work_location.address = params.fetch("query_address")
    the_work_location.city = params.fetch("query_city")
    the_work_location.state = params.fetch("query_state")
    the_work_location.zip_code = params.fetch("query_zip_code")
    the_work_location.description = params.fetch("query_description")
  
    # Update daily opening and closing times
    %w[monday tuesday wednesday thursday friday saturday sunday].each do |day|
      the_work_location.send("#{day}_opening=", params["query_#{day}_opening"])
      the_work_location.send("#{day}_closing=", params["query_#{day}_closing"])
    end
  
    the_work_location.phone_number = params.fetch("query_phone_number", "").gsub(/[^0-9]/, '')
    the_work_location.website = params.fetch("query_website")
    the_work_location.requires_purchase = params.fetch("query_requires_purchase", "0") == "1"
    the_work_location.membership = params.fetch("query_membership", "0") == "1"
  
    # Validate and save
    if the_work_location.valid?
      the_work_location.save
      redirect_to("/work_locations/#{the_work_location.id}", { notice: "Work location updated successfully." })
    else
      redirect_to("/work_locations/#{the_work_location.id}", { alert: the_work_location.errors.full_messages.to_sentence })
    end
  end
  

  def destroy
    the_id = params.fetch("path_id")
    the_work_location = WorkLocation.where({ :id => the_id }).at(0)

    the_work_location.destroy

    redirect_to("/work_locations", { :notice => "Work location deleted successfully."} )
  end

  def search
    query = params[:query]
    coordinates = query.present? ? Geocoder.coordinates(query) : nil
  
    # Base query
    @list_of_work_locations = WorkLocation.all
  
    # Apply geolocation filter if coordinates are available
    if coordinates
      @list_of_work_locations = @list_of_work_locations.near(coordinates)
    end
  
    # Apply filters sequentially on the existing subset
    @list_of_work_locations = @list_of_work_locations.where(location_type_id: params[:type]) if params[:type].present?
  
    if params[:rating].present?
      @list_of_work_locations = @list_of_work_locations
                                  .joins(:ratings)
                                  .group("work_locations.id")
                                  .having("AVG(ratings.stars) >= ?", params[:rating].to_f)
    end
  
    @list_of_work_locations = @list_of_work_locations.where("crowding_average <= ?", params[:crowding].to_i) if params[:crowding].present?
  
    @list_of_work_locations = @list_of_work_locations.where("noise_average <= ?", params[:noise].to_i) if params[:noise].present?
  
    @list_of_work_locations = @list_of_work_locations.where(requires_purchase: true) if params[:requires_purchase] == "1"
  
    @list_of_work_locations = @list_of_work_locations.where(membership: true) if params[:membership] == "1"
  
    # Pass the original query back to the view
    @query = query
  
    render :search
  end
  
  # Helper method to construct a full address
  # Ensure this method is added to the WorkLocation model if not already there
  def full_address
    [address, city, state, zip_code].compact.join(', ')
  end
  
  
  # Helper method to construct a full address
  # Ensure this method is added to the WorkLocation model if not already there
  def full_address
    [address, city, state, zip_code].compact.join(', ')
  end
  

end
