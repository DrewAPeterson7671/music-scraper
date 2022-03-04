class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show edit update destroy ]

  def initialize
    @priority = "Current"
    @pop_list = "Active"
    @greatest_hits = "Unexplored"
    @album = "Unexplored"
    @priority_choices = ["Paragon", "Focus", "Current", "Suspended", "Complete & Revist", "Dislike"]
    @progress_choices = ["Active", "Done", "Unexplored"]
    @genre_choices = 
    ["Alternative", 
      "Classic Rock", 
      "80s Pop", 
      "Punk", 
      "Metal", 
      "Jam Bands", 
      "Rock N Roll", 
      "Soul R&B", 
      "Blues", 
      "Disco", 
      "Reggae", 
      "Hip Hop", 
      "Dance",
      "Pop"]
    @subgenre = 
    ["Progressive Rock", 
      "Hair Metal",
      "Heartland Rock",
      "Psychedelic Rock", 
      "Proto Metal", 
      "Proto Punk", 
      "Funk", 
      "Alternative Metal", 
      "Nu Metal", 
      "Speed Metal", 
      "Ambient", 
      "EDM", 
      "Darkwave", 
      "Electro", 
      "Rave", 
      "Techno", 
      "Trance", 
      "Classic Punk", 
      "Hardcore Punk", 
      "Power Pop", 
      "Oi", 
      "New Wave", 
      "Soft Rock", 
      "Shoegaze", 
      "Post Punk", 
      "Dream Pop", 
      "Industrial Rock", 
      "Goth", 
      "Brit Pop", 
      "College Radio", 
      "Grunge", 
      "Jangle Pop", 
      "Alternative Rap", 
      "Christian Rock", 
      "Motown",
      "90s Pop",
      "00s Pop",
      "10s Pop",
      "20s Pop"]
  end


  # GET /artists or /artists.json
  def index
    @artists = Artist.all
  end

  # GET /artists/1 or /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists or /artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_url(@artist), notice: "Artist was successfully created." }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1 or /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to artist_url(@artist), notice: "Artist was successfully updated." }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1 or /artists/1.json
  def destroy
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url, notice: "Artist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:genre, :subgenre1, :subgenre2, :subgenre3, :priority, :pop_list, :greatest_list, :current_album, :current_song)
    end
end
