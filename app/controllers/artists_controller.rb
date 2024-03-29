class ArtistsController < ApplicationController

  before_action :set_artist, only: %i[ show edit update destroy ] do
    redirect_to new_user_session_path unless current_user #&& current_user.admin
  end

  before_action :load_locals

  # attr_accessor :load_locals_album

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
      "20s Pop",
      "Misc"]
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
      "House",
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
      @to_download_choices = 
      ["Unexplored", "To Do", "No", "Done"]
      @download_type = 
      ["Not Set", "Everything", "Major", "Greatest Hits & Revelant Albums", "Greatest Hits", "Relevant Albums", "Sample"]
      @download_status = 
      ["Not Started", "New Artist Watch", "Ongoing & Active", "Closed", "Current to Date Listed", "Downloading"]
      @album_types = [
        'Studio',
        'EP',
        'Live EP',
        'Remix EP',
        'Live',
        'Greatest Hits',
        'Live Greatest Hits',
        'Compilation',
        'Remix',
        'Box Set',
        'Demo',
        'Video Album',
        'Single'
      ]
  end


  # GET /artists or /artists.json
  def index
    @artists = sort_artist_index.order(:name).paginate(page: params[:page], per_page: 100)

    if params[:search]
      @artists = Artist.search(params['search']).page params[:page]
    end

    if params[:genre_search]
      @artists = Artist.genre_search(params['genre_search']).page params[:page]
    end

  end

  # GET /artists/1 or /artists/1.json
  def show
    @albums = Album.where(artist_id: params[:id]).sort_by &:year
    # @album_type = Album.load_locals
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
      params.require(:artist).permit(
        :name, 
        :genre, 
        :subgenre1, 
        :subgenre2, 
        :subgenre3, 
        :priority, 
        :pop_list, 
        :greatest_list, 
        :album, 
        :current_album, 
        :current_song, 
        :to_download, 
        :download_type, 
        :download_date, 
        :download_status, 
        :wiki_page, 
        :discogs_page, 
        :current_download, 
        :dl_listen_album, 
        :dl_listen_song, 
        :subgenres => [])
      # Need to make download migrations
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
          @artists_sort = Artist.order('name ASC').where("name ~ '^[^A-Za-z0-9]'")
        when params[:letter]
          @artists_sort = Artist.order('name ASC').where("name ILIKE ?", "#{params[:letter]}%")
        else
          @artists_sort = Artist.order('name ASC')
      end
    end
end
