module ScraperHelper
  
  def test_test(name)
    "Hello #{name}!"
  end

  def target_scrape(url)
    browser = Watir::Browser.new(:chrome)
    browser.goto(url)
    @doc = Nokogiri::HTML.parse(URI.open(url))
  end
  
  def league_year_prefix(year, league = 'NBA')
    # aba_seasons = 1968..1976
    baa_seasons = 1947..1949
    baa_seasons.include?(year) ? league_year = "BAA_#{year}" : league_year = "#{league}_#{year}"
  end

  def harvest_franks_page_list(year)
    #1980 to 2019
    @list_store = []
    @doc_list = target_scrape("http://www.frankspage.net/kroq/#{year}.htm")
    @info = @doc_list.css("tbody")
    @info.css('object,embed').each{ |e| e.inner_html = e.inner_html.gsub(/\r\n/,'') }
    rows = @info.css("tr")

    @list_store = rows.css('tr')[1..-1].map { |tr| tr.css('td').map &:text}
  end

  def harvest_radiohitlist_list(year, station)
    # KROQ 1980 to 2013
    # 91X 1983 to 2016
    # Q101 1996 to 2003

    @doc_list = target_scrape("http://www.radiohitlist.com/#{station}/#{station}-#{year}.htm")
    @info = @doc_list.css("table")

    rows = @info.css("tr")
    @list_store_raw = rows.css('tr').map { |tr| tr.css('span').map &:text}
    @list_store_raw = @list_store_raw[0] - ["-"]
    @list_store_raw[0][0..4].each do |lsr|
      if lsr == "Ranking" || lsr == "Artist Name" || lsr == "Song Title" || lsr == "Album Title" || lsr == "Click for sample"
        @list_store_raw[0].shift
      end
    end
    @list_store_raw[0].each do |lsr|
      lsr.slice! "\r\n      "
    end

    # next step, need to break into array of arrays 
  end
  
end
# lsr = lsr.gsub("\r\n      ", "")