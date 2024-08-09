class LocationTypesController < ApplicationController
  def index
    matching_location_types = LocationType.all

    @list_of_location_types = matching_location_types.order({ :created_at => :desc })

    render({ :template => "location_types/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_location_types = LocationType.where({ :id => the_id })

    @the_location_type = matching_location_types.at(0)

    render({ :template => "location_types/show" })
  end

  def create
    the_location_type = LocationType.new
    the_location_type.descriptor = params.fetch("query_descriptor")

    if the_location_type.valid?
      the_location_type.save
      redirect_to("/location_types", { :notice => "Location type created successfully." })
    else
      redirect_to("/location_types", { :alert => the_location_type.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_location_type = LocationType.where({ :id => the_id }).at(0)

    the_location_type.descriptor = params.fetch("query_descriptor")

    if the_location_type.valid?
      the_location_type.save
      redirect_to("/location_types/#{the_location_type.id}", { :notice => "Location type updated successfully."} )
    else
      redirect_to("/location_types/#{the_location_type.id}", { :alert => the_location_type.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_location_type = LocationType.where({ :id => the_id }).at(0)

    the_location_type.destroy

    redirect_to("/location_types", { :notice => "Location type deleted successfully."} )
  end
end
