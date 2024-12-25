class ImagesController < ApplicationController

  def show
    @the_id = params.fetch("path_id")
    @matching_images = Image.where(location_id: @the_id)
    render template: "images/show"
  end

  def create
    the_image = Image.new
    the_image.location_id = params.fetch("path_id")
    the_image.poster_id = current_user.id
    the_image.picture.attach(params[:image_file])

    if the_image.valid?
      the_image.save
      redirect_to("/images/#{the_image.location_id}", notice: "Image created successfully.")
    else
      redirect_to("/images/#{the_image.location_id}", alert: the_image.errors.full_messages.to_sentence)
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_image = Image.find_by(id: the_id)

    if the_image
      the_location = the_image.location_id
      the_image.destroy
      redirect_to("/images/#{the_location}", notice: "Image deleted successfully.")
    else
      redirect_to root_path, alert: "Image not found."
    end
  end

  def insert_image
    location = Location.find(params[:id])
    uploaded_file = params[:image_file]

    if uploaded_file
      image = location.images.build(poster_id: current_user.id)
      image.picture.attach(uploaded_file)
      
      if image.save
        redirect_to location_path(location), notice: "Image uploaded successfully!"
      else
        redirect_to location_path(location), alert: image.errors.full_messages.to_sentence
      end
    else
      redirect_to location_path(location), alert: "No file selected for upload."
    end
  end

  private

  def save_image(uploaded_file)
    # Example: Save the file locally
    file_path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    "/uploads/#{uploaded_file.original_filename}" # Return the relative path
  end
end

