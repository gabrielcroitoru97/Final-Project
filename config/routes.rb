Rails.application.routes.draw do
  # Routes for the Location type resource:

  # CREATE
  post("/insert_location_type", { :controller => "location_types", :action => "create" })
          
  # READ
  get("/location_types", { :controller => "location_types", :action => "index" })
  
  get("/location_types/:path_id", { :controller => "location_types", :action => "show" })
  
  # UPDATE
  
  post("/modify_location_type/:path_id", { :controller => "location_types", :action => "update" })
  
  # DELETE
  get("/delete_location_type/:path_id", { :controller => "location_types", :action => "destroy" })

  #------------------------------

  # Routes for the Favorite place resource:

  # CREATE
  post("/insert_favorite_place", { :controller => "favorite_places", :action => "create" })
          
  # READ
  get("/favorite_places", { :controller => "favorite_places", :action => "index" })
  
  get("/favorite_places/:path_id", { :controller => "favorite_places", :action => "show" })
  
  # UPDATE
  
  post("/modify_favorite_place/:path_id", { :controller => "favorite_places", :action => "update" })
  
  # DELETE
  get("/delete_favorite_place/:path_id", { :controller => "favorite_places", :action => "destroy" })

  #------------------------------

  # Routes for the Image resource:

  # CREATE
  post("/insert_image", { :controller => "images", :action => "create" })
          
  # READ
  get("/images", { :controller => "images", :action => "index" })
  
  get("/images/:path_id", { :controller => "images", :action => "show" })
  
  # UPDATE
  
  post("/modify_image/:path_id", { :controller => "images", :action => "update" })
  
  # DELETE
  get("/delete_image/:path_id", { :controller => "images", :action => "destroy" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Rating resource:

  # CREATE
  post("/insert_rating", { :controller => "ratings", :action => "create" })
          
  # READ
  get("/ratings", { :controller => "ratings", :action => "index" })
  
  get("/ratings/:path_id", { :controller => "ratings", :action => "show" })
  
  # UPDATE
  
  post("/modify_rating/:path_id", { :controller => "ratings", :action => "update" })
  
  # DELETE
  get("/delete_rating/:path_id", { :controller => "ratings", :action => "destroy" })

  #------------------------------

  devise_for :users

  # Routes for the Work location resource:

  # CREATE
  post("/insert_work_location", { :controller => "work_locations", :action => "create" })
          
  # READ
  get("/work_locations", { :controller => "work_locations", :action => "index" })
  
  get("/work_locations/:path_id", { :controller => "work_locations", :action => "show" })
  
  # UPDATE
  
  post("/modify_work_location/:path_id", { :controller => "work_locations", :action => "update" })
  
  # DELETE
  get("/delete_work_location/:path_id", { :controller => "work_locations", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
