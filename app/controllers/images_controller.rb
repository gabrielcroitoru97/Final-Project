class ImagesController < ApplicationController


  def show
    @the_id = params.fetch("path_id")

    @matching_images = Image.where({ :location_id => @the_id })

    render({ :template => "images/show" })
  end

  def create
    the_image = Image.new
    the_image.location_id = params.fetch("path_id")
    the_image.poster_id = current_user.id
    the_image.picture = params.fetch("query_image_url")

    if the_image.valid?
      the_image.save
      redirect_to("/images/#{the_image.location_id}", { :notice => "Image created successfully." })
    else
      redirect_to("/images/#{the_image.location_id}", { :alert => the_image.errors.full_messages.to_sentence })
    end
  end



  def destroy
    the_id = params.fetch("path_id")
    the_image = Image.where({ :id => the_id }).at(0)
    the_location=the_image.location_id
    the_image.destroy

    redirect_to("/images/#{the_location}", { :notice => "Image deleted successfully."} )
  end
end
