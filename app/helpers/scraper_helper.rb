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
        lsa.gsub!(/\\n|\\t/)
        # lsa.slice! "\r\n      "
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
  end

  def rocklists_by_year(year)
    # append station and year to instance to ID it?
    doc_list = target_scrape("https://www.rocklists.com#{year}")
    info = doc_list.css('div.entry-content')
    @year_list = []

    info.css('p').each { |i| @year_list  << i.try(:text) }
    
    @year_list = @year_list.map { |yl| yl.split(/\. | - /) }
  
    @year_list = @year_list.map do |yl| 
      yl.map do |yla|
        yla.gsub!(/\\n|\\t/, "")
        yla.strip
      end
    end
  end

  def frankspage(year)
    # includes more songs for 2010 to 2018, no albums
    doc_list = target_scrape("http://www.frankspage.net/kroq/#{year}")
    info = doc_list.css('table.kroq')
    @year_list = []
    rows = info.css("tr")

    @year_list = rows.css('tr').map { |tr| tr.css('td').map &:text}
    @year_list.delete_if(&:blank?)

    @year_list = @year_list.map do |yl| 
      yl.map do |yla|
        yla.gsub!("\n", "")
        yla.gsub!("\t", "")
        yla.strip
      end
    end
  end

  def billboardtop100_to_1958(year)
    # 1940 to 1958
    # merge these with billboard wiki
    if year = "1940" 
      year = "336"
    end

    doc_list = target_scrape("http://billboardtop100of.com/#{year}-2")

    info = doc_list.css('div.entry-content')
    @year_list = []

    rows = info.css("p")
    info.css('p').each { |i| @year_list  << i.try(:text) }
    @year_list = @year_list[0].split("\n")
    @year_list = @year_list2.map { |yl| yl.split(/\. | – /) }
  end

  def billboard_wiki(year)
    # from 1959 to 2021
    # however 1946 to 1958 doesn't have the annoying artist slashes
    doc_list = target_scrape("https://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_#{year}")
    info = doc_list.css('table.wikitable')
    @year_list = []
    rows = info.css("tr")

    @year_list = rows.css('tr').map { |tr| tr.css('td').map &:text}
    @year_list.delete_if(&:blank?)

    @year_list.map do |yl|
      yl.map do |yla|
        yla.gsub!("\"", "")
        yla.gsub!("\n", "")
      end
    end

    @year_list.map do |yl|
      yl[1], yl[2] = yl[2], yl[1]
    end
  end

  def indie_shuffle
    # This site is dynamic
    doc_list = target_scrape("https://www.indieshuffle.com/songs/alternative/")
    info = doc_list.css('div.scrollerList')
    @current_list = []
    rows = info.css("h5")

    @current_list = rows.map do |row|
      initial = row.at_css("h5").children.text
    end

    rows_artist = rows.css("strong").text
    rows_song = rows.css("h5").text


    # these worked
    rows_song = rows.at_css("h5").children.text
    test = rows_song.gsub!("\n", '').strip
    test = test.split(" - ")
    # map and strip

    <a class="number-page ajaxlink active" rel="noindex" href="/songs/alternative/page/1" data-href="/songs/content/songs/alternative/page/1" data-holder="#leftContainer">
      1 
    </a>


    "https://www.indieshuffle.com/songs/alternative/page/1" # 1 to 107
    "https://www.indieshuffle.com/songs/alternative-rock/" # 1 to 51
    "https://www.indieshuffle.com/songs/indie-rock/" # 1 to 453
    "https://www.indieshuffle.com/songs/rock/" # 1 to 80
    "https://www.indieshuffle.com/songs/indie-pop/" # 1 to 467
    "https://www.indieshuffle.com/songs/dream-pop/" # 1 to 138
    "https://www.indieshuffle.com/songs/garage-rock/" # 1 to 36
    "https://www.indieshuffle.com/songs/synth-pop/" # 1 to 214
    "https://www.indieshuffle.com/songs/electro-pop/" # 1 to 235
    "https://www.indieshuffle.com/songs/electronic/" # 1 to 782
    "https://www.indieshuffle.com/songs/shoegaze/" # 1 to 47
    "https://www.indieshuffle.com/songs/psychedelic/" # 1 to 67
    "https://www.indieshuffle.com/songs/psychedelic-pop/" # 1 to 50
    "https://www.indieshuffle.com/songs/punk/" # 1 to 19
    "https://www.indieshuffle.com/songs/punk-rock/" # 1 to 10
    "https://www.indieshuffle.com/songs/post-punk/" # 1 to 31
    "https://www.indieshuffle.com/songs/alternative-indie/" # 1 to 12

    "https://www.indieshuffle.com/songs/alternative/songs/content/songs/alternative/page/1"
    



  end

    # other countdowns are not homogenous and may need special handling by station

end

# @year_list.each { |yl| yl.gsub!("\n\n\t", "") }
# @year_list.each { |yl| yl.gsub!("\n\n\n", "") }