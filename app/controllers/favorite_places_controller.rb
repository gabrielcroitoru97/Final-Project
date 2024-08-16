class FavoritePlacesController < ApplicationController


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


  def destroy
    the_place_id = params.fetch("path_id")
    
    the_favorite_place = FavoritePlace.where({ :place_id => the_place_id }).where({:user_id=>current_user.id}).at(0)

    the_favorite_place.destroy

    redirect_to("/work_locations/#{the_place_id}", { :notice => "Removed Favorite Place"} )
  end
end
