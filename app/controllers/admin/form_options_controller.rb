class Admin::FormOptionsController < Admin::ApplicationController
  def index
    @form_options = FormOption.all
  end

  def new
    @form_option = FormOption.new
  end

  def create
    @form_option = FormOption.new(form_option_params)
    if @form_option.save
      redirect_to admin_form_options_path, notice: "Option created successfully."
    else
      render :new, alert: "Failed to create option."
    end
  end

  def edit
    @form_option = FormOption.find(params[:id])
  end

  def update
    @form_option = FormOption.find(params[:id])
    if @form_option.update(form_option_params)
      redirect_to admin_form_options_path, notice: "Option updated successfully."
    else
      render :edit, alert: "Failed to update option."
    end
  end

  def destroy
    @form_option = FormOption.find(params[:id])
    @form_option.destroy
    redirect_to admin_form_options_path, notice: "Option deleted successfully."
  end

  private

  def form_option_params
    params.require(:form_option).permit(:name, :value, :category)
  end
end

