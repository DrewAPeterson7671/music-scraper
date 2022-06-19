class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
    @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.find(params[:id])
  end

  # GET /albums/new
  def new
    @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.new
  end

  # GET /albums/1/edit
  def edit
    @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.find(params[:id])
  end

  # POST /albums or /albums.json
  def create
    @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.new(album_params)

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
    @artist = Artist.find(params[:artist_id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to artist_path(@artist), notice: "Album was successfully destroyed." }
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
      params.require(:album).permit(:album_name, :artist_id, :year, :album_genre, :album_priority, :album_type, :album_complete, :album_download, :current_album_song, :album_version, :download_verified, :download_status, :rating, :normalized_tagged, :compiliation, :album_sub_genre1, :album_sub_genre2)
    end
end
