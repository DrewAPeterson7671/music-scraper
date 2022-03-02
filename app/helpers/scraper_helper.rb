module ScraperHelper
  
  def test_test(name)
    "Hello #{name}!"
  end

  def target_scrape(url)
    browser = Watir::Browser.new(:chrome)
    browser.goto(url)
    @doc = Nokogiri::HTML.parse(URI.open(url))
  end
  
  def harvest_franks_page_list(year)
    #1980 to 2019
    @list_store = []
    doc_list = target_scrape("http://www.frankspage.net/kroq/#{year}.htm")
    info = doc_list.css("tbody")
    info.css('object,embed').each{ |e| e.inner_html = e.inner_html.gsub(/\r\n/,'') }
    rows = info.css("tr")

    @list_store = rows.css('tr')[1..-1].map { |tr| tr.css('td').map &:text}
  end

  def harvest_radiohitlist_list(year, station)
    # KROQ 1980 to 2013
    # 91X 1983 to 2016
    # Q101 1996 to 2003

    doc_list = target_scrape("http://www.radiohitlist.com/#{station}/#{station}-#{year}.htm")
    info = doc_list.css("table")
    rows = info.css("tr")
    @list_store = rows.css('tr')[1..-1].map { |tr| tr.css('span').map &:text}

    @list_store.delete_if(&:blank?)

    @list_store.reject! do |ls|
      ls == ["Ranking", "Artist Name", "Song Title", "Album Title", "Click for sample"]
    end
    
    @list_store.each do |ls|
      ls.reject! do |lsa|
        lsra == "-"
      end
    end

    @list_store.each do |ls|
      ls.each do |lsa|
        lsa.slice! "\r\n      "
      end
    end
  end

  def rocklists_stations
    doc_list = target_scrape("https://www.rocklists.com/radiostations.html")
    info = doc_list.css('div.entry-content')
    @station_list = []

    info.css('a').each do |i|
      @station_list << i.try(:text)
      @station_list << i['href']
    end

    # @info.css('a')[0]['href']
    # @info.css('a')[0].try(:text)

  end
  
  def rocklists_years_gather(url)
    doc_list = target_scrape("https://www.rocklists.com#{url}")
    info = doc_list.at('p:contains("Year-End Countdowns available: ")')
    @list_years = []
    info.css('a').each do |i|
      @list_years << i.try(:text)
      @list_years << i['href']
    end
    @other_countdowns = []
    info = doc_list.at('p:contains("Other Countdowns available: ")')
    info.css('a').each do |i|
      @other_countdowns << i.try(:text)
      @other_countdowns << i['href']
    end

    def rocklists_by_year(url)
      # append station and year to instance to ID it?
      doc_list = target_scrape("https://www.rocklists.com#{url}")
      info = doc_list.css('div.entry-content')
      @year_list = []

      info.css('p').each { |i| @year_list  << i.try(:text) }
      @year_list.each { |yl| yl.gsub!("\n\n\t", "") }
      @year_list.each { |yl| yl.gsub!("\n\n\n", "") }
      end
      # Need to use regex to split up each string into rank, artist, song

    end
    # other countdowns are not homogenous and may need special handling by station
  end

end

