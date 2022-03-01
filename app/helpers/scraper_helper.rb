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
    @list_store_raw = rows.css('tr')[1..-1].map { |tr| tr.css('span').map &:text}

    @list_store_raw.delete_if(&:blank?)

    @list_store_raw.reject! do |lsr|
      lsr == ["Ranking", "Artist Name", "Song Title", "Album Title", "Click for sample"]
    end
    
    @list_store_raw.each do |lsr|
      lsr.reject! do |lsra|
        lsra == "-"
      end
    end

    @list_store_raw.each do |lsr|
      lsr.each do |lsra|
        lsra.slice! "\r\n      "
      end
    end
  end
  
end

