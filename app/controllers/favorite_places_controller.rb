class FavoritePlacesController < ApplicationController
  def index
    matching_favorite_places = FavoritePlace.where({:user_id=>current_user.id})

    @list_of_favorite_places = matching_favorite_places.order({ :created_at => :desc })

    render({ :template => "favorite_places/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_favorite_places = FavoritePlace.where({ :id => the_id })

    @the_favorite_place = matching_favorite_places.at(0)

    render({ :template => "favorite_places/show" })
  end

  def create
    the_favorite_place = FavoritePlace.new
    the_favorite_place.user_id = current_user.id
    the_favorite_place.place_id = params.fetch("path_id")
    the_favorite_place.note = params.fetch("query_note")

    if the_favorite_place.valid?
      the_favorite_place.save
      redirect_to("/work_locations/#{the_favorite_place.place_id}", { :notice => "Favorite place created successfully." })
    else
      redirect_to("/work_locations/#{the_favorite_place.place_id}", { :alert => the_favorite_place.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_favorite_place = FavoritePlace.where({ :id => the_id }).at(0)

    the_favorite_place.user_id = params.fetch("query_user_id")
    the_favorite_place.place_id = params.fetch("query_place_id")
    the_favorite_place.note = params.fetch("query_note")

    if the_favorite_place.valid?
      the_favorite_place.save
      redirect_to("/favorite_places/#{the_favorite_place.id}", { :notice => "Favorite place updated successfully."} )
    else
      redirect_to("/favorite_places/#{the_favorite_place.id}", { :alert => the_favorite_place.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_place_id = params.fetch("path_id")
    
    the_favorite_place = FavoritePlace.where({ :place_id => the_place_id }).where({:user_id=>current_user.id}).at(0)

    the_favorite_place.destroy

    redirect_to("/work_locations/#{the_place_id}", { :notice => "Removed Favorite Place"} )
  end
end
