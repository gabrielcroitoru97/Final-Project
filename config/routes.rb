Rails.application.routes.draw do
  

  root to: "work_locations#index"
  
  get("/profile", {:controller => "homepage", :action => "profile"})

  # Routes for the Location type resource:


 
  #------------------------------
  # Routes for the Favorite place resource:
  # CREATE
  post("/insert_favorite_place/:path_id", { :controller => "favorite_places", :action => "create" })
  # READ

  get("/favorite_places/:path_id", { :controller => "favorite_places", :action => "show" })
  # DELETE
  get("/delete_favorite_place/:path_id", { :controller => "favorite_places", :action => "destroy" })
  #------------------------------
  # Routes for the Image resource:
  # CREATE
  post("/insert_image/:path_id", { :controller => "images", :action => "create" })

  get("/images/:path_id", { :controller => "images", :action => "show" })

  # DELETE
  get("/delete_image/:path_id", { :controller => "images", :action => "destroy" })
  
  #------------------------------
  # Routes for the Rating resource:
  # CREATE
  post("/insert_rating", { :controller => "ratings", :action => "create" })
  get("/add_rating/:path_id", { :controller => "ratings", :action => "add" })

  # DELETE
  get("/delete_rating/:path_id", { :controller => "ratings", :action => "destroy" })
  #------------------------------
  devise_for :users
  # Routes for the Work location resource:
  # CREATE
  post("/insert_work_location", { :controller => "work_locations", :action => "create" })
  get("/new/work_location",{:controller => "work_locations", :action=>"new_page"})
  get("/edit_work_location/:path_id", { :controller => "work_locations", :action => "edit" })
  # READ
  get("/work_locations", { :controller => "work_locations", :action => "index" })
  get("/work_locations/:path_id", { :controller => "work_locations", :action => "show" })
  # UPDATE
  post("/modify_work_location/:path_id", { :controller => "work_locations", :action => "update" })
  # DELETE
  get("/delete_work_location/:path_id", { :controller => "work_locations", :action => "destroy" })
  #------------------------------

  
end
