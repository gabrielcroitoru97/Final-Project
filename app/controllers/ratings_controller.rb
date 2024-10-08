class RatingsController < ApplicationController



  def add
    @location_id = params.fetch("path_id")
    render({ :template => "ratings/new" })
  end

  def create
    the_rating = Rating.new
    the_rating.user_id = params.fetch("query_user_id")
    the_rating.location_id = params.fetch("query_location_id")
    the_rating.stars = params.fetch("query_stars")
    the_rating.content = params.fetch("query_content")
    the_rating.wifi_rating = params.fetch("query_wifi_rating")
    the_rating.crowding_score = params.fetch("query_crowding_score")
    the_rating.noise_level = params.fetch("query_noise_level")
    
    the_work_location=WorkLocation.where({:id=>the_rating.location_id}).at(0)
    the_work_location.average_rating  = Rating.where({:location_id =>the_work_location.id}).average(:stars)
    the_work_location.crowding_average =Rating.where({:location_id =>the_work_location.id}).average(:crowding_score)
    the_work_location.noise_average  =Rating.where({:location_id =>the_work_location.id}).average(:noise_level)
    the_work_location.wifi_speed =Rating.where({:location_id =>the_work_location.id}).average(:wifi_rating)

    if the_rating.valid?
      the_rating.save
      redirect_to("/work_locations/#{the_rating.location_id}", { :notice => "Rating created successfully." })
    else
      redirect_to("/work_locations/#{the_rating.location_id}", { :alert => the_rating.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)
    the_location=the_rating.location_id
    the_rating.destroy

    redirect_to("/work_locations/#{the_location}", { :notice => "Rating deleted successfully."} )
  end
end
