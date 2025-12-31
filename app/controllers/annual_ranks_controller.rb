class AnnualRanksController < ApplicationController
  # before_action :set_annual_rank

  before_action :load_locals

  def load_locals
    @to_download_choices = 
    [ nil, "To Download", "To Process", "Done"]
  end

  # GET /annual_ranks or /annual_ranks.json
  def index
    if params[:source].present? && params[:year].present?
      @annual_ranks = AnnualRank.where(:source => params[:source]).where(:year => params[:year]).order(:rank)
    elsif params[:source].present?
      @annual_ranks = AnnualRank.where(:source => params[:source]).order(:year, :rank).paginate(page: params[:page], per_page: 200)
    elsif params[:rank_genre].present? && params[:year].present?
      @annual_ranks = AnnualRank.where(:rank_genre => params[:rank_genre]).where(:year => params[:year]).order(:source, :rank).paginate(page: params[:page], per_page: 200)
    elsif params[:alt_collection].present?
      @annual_ranks = AnnualRank.where( :alt_collection => true ).order(:rank_artist, :rank_track).paginate(page: params[:page], per_page: 200)
    else
      @annual_ranks = AnnualRank.all.order(:source, :year, :rank).paginate(page: params[:page], per_page: 200)
    end

    @consolidated_ranks_by_year = ConsolidatedAnnualRank.all.group_by(&:year)    

    # @consolidated_ranks_by_year = ConsolidatedAnnualRank.all.group_by(&:year).paginate(page: params[:page], per_page: 200)

    # @rank_sorters = AnnualRank.where(rank_genre: "Alternative All-Time" ).order(:source, :year, :rank).paginate(page: params[:page], per_page: 200)

    # if params[:sort].present?
    #   @annual_rank = @annual_rank.order(params[:sort])
    # end
  end

  # GET /annual_ranks/1 or /annual_ranks/1.json
  def show
    @annual_rank = AnnualRank.find(params[:id])
  end

  # GET /annual_ranks/new
  def new
    @annual_rank = AnnualRank.new
  end

  # GET /annual_ranks/1/edit
  def edit
    @annual_rank = AnnualRank.find(params[:id])
  end

  # POST /annual_ranks or /annual_ranks.json
  def create
    @annual_rank = AnnualRank.new(annual_rank_params)

    respond_to do |format|
      if @annual_rank.save
        format.html { redirect_to annual_rank_url(@annual_rank), notice: "Annual rank was successfully created." }
        format.json { render :show, status: :created, location: @annual_rank }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @annual_rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /annual_ranks/1 or /annual_ranks/1.json
  def update
    @annual_rank = AnnualRank.find(params[:id])
    respond_to do |format|
      if @annual_rank.update(annual_rank_params)
        format.html { redirect_to annual_rank_url(@annual_rank), notice: "Annual rank was successfully updated." }
        format.json { render :show, status: :ok, location: @annual_rank }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @annual_rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annual_ranks/1 or /annual_ranks/1.json
  def destroy
    @annual_rank = AnnualRank.find(params[:id])
    @annual_rank.destroy

    respond_to do |format|
      format.html { redirect_to annual_ranks_url, notice: "Annual rank was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit_all
    @annual_ranks = AnnualRank.all
  end

  def update_all
    params['annual_rank'].keys.each do |id|
      @annual_ranks = AnnualRank.find(id.to_i)
      @annual_ranks.update_attributes(params['annual_ranks'][id])
    end
    redirect_to(annual_ranks_url)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_annual_rank
      @annual_rank = AnnualRank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def annual_rank_params
      params.require(:annual_rank).permit( :year, :rank, :source, :rank_artist, :rank_track, :rank_album, :rank_listened, :rank_genre, :alt_collection, :to_download )
    end
end
