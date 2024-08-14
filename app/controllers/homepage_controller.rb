class HomepageController < ApplicationController
  

  def profile
    matching_favorite_places = FavoritePlace.where({:user_id=>current_user.id})

    @list_of_favorite_places = matching_favorite_places.order({ :created_at => :desc })
    
    render({:template => "user_views/profile"})

  end
end
