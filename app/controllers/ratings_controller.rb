class RatingsController < ApplicationController
  def index
    matching_ratings = Rating.all

    @list_of_ratings = matching_ratings.order({ :created_at => :desc })

    render({ :template => "ratings/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_ratings = Rating.where({ :id => the_id })

    @the_rating = matching_ratings.at(0)

    render({ :template => "ratings/show" })
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

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings", { :notice => "Rating created successfully." })
    else
      redirect_to("/ratings", { :alert => the_rating.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    the_rating.user_id = params.fetch("query_user_id")
    the_rating.location_id = params.fetch("query_location_id")
    the_rating.stars = params.fetch("query_stars")
    the_rating.content = params.fetch("query_content")
    the_rating.wifi_rating = params.fetch("query_wifi_rating")
    the_rating.crowding_score = params.fetch("query_crowding_score")
    the_rating.noise_level = params.fetch("query_noise_level")

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings/#{the_rating.id}", { :notice => "Rating updated successfully."} )
    else
      redirect_to("/ratings/#{the_rating.id}", { :alert => the_rating.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    the_rating.destroy

    redirect_to("/ratings", { :notice => "Rating deleted successfully."} )
  end
end
