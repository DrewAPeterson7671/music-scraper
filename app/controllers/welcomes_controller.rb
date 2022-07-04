class WelcomesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :new, :create, :edit, :update, :destroy]

  def index
    @placeholder = Welcome.all
  end

  def new
    @placeholder = Welcome.new
  end

  def edit
  end

  def create
    @placeholder = Welcome.new(welcome_params.merge(:user_id => current_user.id))

    respond_to do |format|
      if @placeholder.save 
        format.html {redirect to home_url(@placeholder), notice: "Placeholder updated"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @placeholder.update(welcome_params) 
        format.html {redirect to home_url(@placeholder), notice: "Placeholder updated"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artist.destroy

    respond_to do |format|
      format.html {redirect to home_url(@placeholder), notice: "Placeholder deleted"}
    end
  end

private

  def welcome_params
    params.require(:welcome).permit(:user_id, :placeholder)

  end

end
