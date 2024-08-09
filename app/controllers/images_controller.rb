class ImagesController < ApplicationController
  def index
    matching_images = Image.all

    @list_of_images = matching_images.order({ :created_at => :desc })

    render({ :template => "images/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_images = Image.where({ :id => the_id })

    @the_image = matching_images.at(0)

    render({ :template => "images/show" })
  end

  def create
    the_image = Image.new
    the_image.location_id = params.fetch("query_location_id")
    the_image.poster_id = params.fetch("query_poster_id")
    the_image.picture = params.fetch("query_picture")

    if the_image.valid?
      the_image.save
      redirect_to("/images", { :notice => "Image created successfully." })
    else
      redirect_to("/images", { :alert => the_image.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_image = Image.where({ :id => the_id }).at(0)

    the_image.location_id = params.fetch("query_location_id")
    the_image.poster_id = params.fetch("query_poster_id")
    the_image.picture = params.fetch("query_picture")

    if the_image.valid?
      the_image.save
      redirect_to("/images/#{the_image.id}", { :notice => "Image updated successfully."} )
    else
      redirect_to("/images/#{the_image.id}", { :alert => the_image.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_image = Image.where({ :id => the_id }).at(0)

    the_image.destroy

    redirect_to("/images", { :notice => "Image deleted successfully."} )
  end
end
