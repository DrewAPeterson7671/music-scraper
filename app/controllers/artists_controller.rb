class ArtistsController < ApplicationController

  before_action :set_artist, only: %i[ show edit update destroy ]
  before_action :load_locals

  def load_locals
    @priority_choices = ["Current", "Paragons", "Focus", "Set Aside", "Complete & Revisit", "Don't Like"]
    @status_choices = ["Active", "Unexplored", "Done"]
    @priority_choices = ["Paragon", "Focus", "Current", "Suspended", "Complete & Revist", "Dislike"]
    @progress_choices = ["Active", "Done", "Unexplored"]
    @genre_choices = 
    ["Alternative",
      "Blues",
      "Christian",
      "Classic Rock",
      "Classical",
      "Country",
      "Dance",
      "Disco",
      "Hip Hop",
      "Jam Bands",
      "Jazz",
      "Metal",
      "New Age",
      "Punk",
      "Reggae",
      "Rock N Roll",
      "Soul R&B",
      "40s Pop",
      "50s Pop",
      "60s Pop",
      "70s Pop",
      "80s Pop",
      "90s Pop",
      "00s Pop",
      "10s Pop",
      "20s Pop"]
    @subgenre_choices = 
    ["",
      "Alternative Metal",
      "Alternative Rap",
      "Ambient",
      "Brit Pop",
      "Classic Punk",
      "College Radio",
      "Darkwave",
      "Dream Pop",
      "EDM",
      "Electro",
      "Funk",
      "Goth",
      "Grunge",
      "Hair Metal",
      "Hardcore Punk",
      "Heartland Rock",
      "Industrial Rock",
      "Jangle Pop",
      "Motown",
      "New Wave",
      "Nu Metal",
      "Oi",
      "Old School Hip Hop",
      "Post Punk",
      "Power Pop",
      "Progressive Rock",
      "Proto Metal",
      "Proto Punk",
      "Psychedelic Rock",
      "Rave",
      "Shoegaze",
      "Soft Rock",
      "Speed Metal",
      "Techno",
      "Trance"]
  end


  # GET /artists or /artists.json
  def index
    @artists = sort_artist_index.page params[:page]

    if params[:search]
      @search_results = Artist.search(:search)
      # binding.pry
    end

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

    artist_name(@artist)

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
      params.require(:artist).permit(:name, :genre, :subgenre1, :subgenre2, :subgenre3, :priority, :pop_list, :greatest_list, :album, :current_album, :current_song)
    end

    def artist_name(artist)
      pattern_a = /^((a)\s)/i
      pattern_the = /^((the)\s)/i

      return artist.name.sub!(pattern_a, "").concat(', A') if artist.name.match?(pattern_a)
      return artist.name.sub!(pattern_the, "").concat(', The') if artist.name.match?(pattern_the)
    end

    def sort_artist_index
      case
        when params[:letter] == "#"
          @artists_sort = Artist.order('name ASC').where("name ~ '^[0-9]'")
        when params[:letter] == "?"
          @artists_sort = Artist.order('name ASC').where("name ~ '^[^A-Z0-9]'")
        when params[:letter]
          @artists_sort = Artist.order('name ASC').where("name LIKE ?", "#{params[:letter]}%")
        else
          @artists_sort = Artist.order('name ASC')
      end
    end
end
