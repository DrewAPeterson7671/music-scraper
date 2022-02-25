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
    @list_store = []
    @doc_list = target_scrape("http://www.radiohitlist.com/KROQ/#{station}-#{year}.htm")
    @info = @doc_list.css("table")

    ## left off here
    
    @info.css('object,embed').each{ |e| e.inner_html = e.inner_html.gsub(/\r\n/,'') } # NOT WORKING
    rows = @info.css("tr")
    @list_store = rows.css('tr').map { |tr| tr.at_css('td:font:p:span').map &:text} # trouble with this
    #tr.td.font.p.span.text
  end

end