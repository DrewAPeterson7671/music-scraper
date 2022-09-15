class WelcomesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_welcome

  def index
    # @welcome = Welcome.find_by(user_id: current_user.id)
  end

  def new
  end

  def edit
  end

  def create
    @welcome = Welcome.new(welcome_params)

    if @welcome.save 
      redirect_to root_path(@welcome), notice: "Placeholder created"
    else
      redirect_to root_path(@welcome), notice: "Placeholder not created"
    end
  end

  def update
    if @welcome.update(welcome_params) 
      redirect_to root_path(@welcome), notice: "Placeholder Updated"
    else
      redirect_to root_path(@welcome), notice: "Placeholder not saved"
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
    if current_user
      @welcome = Welcome.find_by(user_id: current_user.id)
    end
  end

end
