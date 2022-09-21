class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ] do
    redirect_to new_user_session_path unless current_user #&& current_user.admin
  end

  before_action :load_locals

  def load_locals
    @album_queue_choices = ["", "VAR Queue", "OST Queue", "Tribute Queue", "Previous", "Billboard", "Top Independent", "VAR", "MP3Album", "MP3VAR", "MP3OST", "MP3Tribute"]
    @album_type_choices = [
      "", 
      "Studio", 
      "EP", 
      "Live EP", 
      "Remix EP", 
      "Live", 
      "Greatest Hits", 
      "Live Greatest Hits", 
      "Compilation", 
      "Remix", 
      "Box Set", 
      "Demo",
      "Video Album", 
      "Single"]
    @album_download_choices = ["", "Listed", "Priority", "Queue", "Verified"]
    @album_version_choices = ["", "Remaster", "Extended Edition", "Special Edition", "Anniversary Edition", "Demo"]
    @download_status_choices = ["", "Track Count", "Tested", "Tagged", "Normalized", "Done", "Imperfect But Rare"]
    @listen_choices = ['Now', 'Later', 'Done']
  end

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
    @album = Album.find(params[:id])
    @artist = Artist.find(@album.artist_id)
  end

  # GET /albums/new
  def new
    @artist = Artist.find(params[:artist_id])
    @album = Album.new
    @album.artist_id = @artist.id

    # @album = Album.new
    # @album.artist_id = @artist.id
    # @artist.album.artist_id = Artist.find(params[:id])
    # @album = @artist.albums.new
    # @album = Album.find(params[:id])
    # @artist = Artist.find(@album.artist_id)
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
    @artist = Artist.find(@album.artist_id)
  end

  # POST /albums or /albums.json
  def create
    @artist = Artist.find(params[:artist_id])
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to artist_path(@artist), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to artist_album_path, notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to artist_path(@album), notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(
        :album_name, 
        :artist_id, 
        :year, 
        :album_queue, 
        :album_type, 
        :album_download, 
        :album_version, 
        :download_status, 
        :rating, 
        :listen,
        :current_album_song)
    end
end
