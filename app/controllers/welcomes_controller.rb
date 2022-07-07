class WelcomesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_welcome

  def index
    @welcome = Welcome.find_by(user_id: current_user.id)
  end

  def new
  end

  def edit
  end

  def create
    @welcome = Welcome.new(welcome_params)

    respond_to do |format|
      if @welcome.save 
        format.html {redirect to home_url(@welcome), notice: "Placeholder updated"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    @welcome = Welcome.find(params[:id]
    respond_to do |format|
      if @welcome.update(welcome_params) 
        format.html {redirect to home_url(@welcome), notice: "Placeholder updated"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @artist.destroy

    respond_to do |format|
      format.html {redirect to home_url(@welcome), notice: "Placeholder deleted"}
    end
  end

private

  def welcome_params
    params.require(:welcome).permit(:user_id, :placeholder)

  end

  def set_welcome
    # @welcome = Welcome.find_by(:user_id)
  end

end
