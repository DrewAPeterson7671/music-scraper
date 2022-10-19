module ScraperHelper
  
  def test_test(name)
    "Hello #{name}!"
  end

  def target_scrape(url)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_preference('webkit.webprefs.loads_images_automatically', false)

    browser = Watir::Browser.new :chrome, options: options
    browser.goto(url)
    @doc = Nokogiri::HTML.parse(URI.open(url))
  end
  
  def target_scrape_xml(url)
    #Incomplete
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_preference('webkit.webprefs.loads_images_automatically', false)

    browser = Watir::Browser.new :chrome, options: options
    browser.goto(url)
    @doc = Nokogiri::XML(builder.to_xml)
  end


  def harvest_franks_page_list(year)
    #1980 only DONE
    lists = []
    doc_list = target_scrape("http://www.frankspage.net/kroq/#{year}.htm")
    info = doc_list.css("tbody")
    info.css('object,embed').each{ |e| e.inner_html = e.inner_html.gsub(/\\r|\\n|\\t/,'') }
    rows = info.css("tr")

    lists = rows.css('tr')[1..-1].map { |tr| tr.css('td').map &:text}

    lists.map do |list|
      list.map do |lis|
        lis = lis.gsub("\n\t\t\t", '')
      end
    end
  end

  def harvest_franks_page_list_no_album(year)
    #1981 to 2019 DONE
    lists = []
    doc_list = target_scrape("http://www.frankspage.net/kroq/#{year}.htm")
    info = doc_list.css("table").wait_until(&:present?)
    # p info
    info.css('object,embed').each{ |e| e.inner_html = e.inner_html.gsub(/\\r|\\n|\\t/,'') }
    rows = info.css("tr")

    lists = rows.css('tr')[1..-1].map { |tr| tr.css('td').map &:text}

    lists.map do |list|
      list.map do |lis|
        lis = lis.gsub("\n\t\t\t", '')
      end
    end
  end


  def harvest_radiohitlist_list(year, station)
    # KROQ 1980 to 2013 DONE
    # 91X 1983 to 2016 DONE
    # Q101 1996 to 2003 DONE

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
        lsa == "-"
      end
    end

    @list_store.map do |ls|
      ls.map do |lsa|
        lsa = lsa.gsub("\r\n      ", "")
        # lsa.gsub!(/\\n\\t\\t\\t/, '')
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
  
  def rocklists_years_gather(station, year)
    # CURRENT WORK
    # KROQ - Already Have
    # Live 105 ('kits') 1986-2007 DONE
    # Q101 - I have 1996 to 2003, 1996 only 24 DONE
            # Need 1993, 94, 95, 96 and 04, 05, 06, 07 DONE
    # 91X - Already Have
    # WHFS - 1992, 94, 95, 96, 97, 98, 99, 00-04 2000, 01, 02, 03!! Problem use _qm DONE
    # WLIR/WDRE Long Island 87 88 DONE
    # K-Rock New York - Links no good 
    # WFNX Boston 1998, 1999, 2001, 2002, 03, 05-07 Problem 2005 DONE
    # KNDD The End Seattle 97,98,99,00,01,02,04,05,06,07 DONE
    # WOXY Cincinnati 1984 DONE
    # 89X Detroit 99 00 01 02 03 04 05 06 07 DONE
    # CD101 Columbus 01 02 03 04 05 06 07 DONE
    # Y100 Philadelphia 02 03 04 05 06 DONE
    # CFNY Toronto 90 91 01 03 04 05 06 DONE
    # CHOI Quebec 04 05 07 DONE
    # CKQB The Bear Ottawa 03 04 06 DONE
    # WBZT The Buzz Montreal 00 01 02 03 04 05 06 DONE
    # The Rock Hartford 00 01 02 03 04 05 06 07 DONE
    # KCNL 02 03 04 05 DONE
    # Virgin Radio London 93 94 95 96 97 98 99 00 01 02 DONE
    # Triple J Australia 93 - 06 DONE
    # Radio and Records 94-06 DONE
    # Left off needing CRNC - beware the hard rock station



    @list_years = []
    doc_list = target_scrape("https://www.rocklists.com/#{station}-#{year}.html")
    info = doc_list.at('div.col-sm-12')
    info2 = info.css('p').try(:text).to_s()

    info3 = info2.force_encoding('iso8859-1').encode('utf-8')
    @info4 = info3.split("\n\n\t")

    puts @info4

    @info4.each do |info|
      info = info.gsub(/(?:\d)(\. )/, ' - ')
      @list_years << info.split(/( - )/)
    end

    @list_years.each_with_index do |list_year, i|
      list_year.delete(' - ')
      list_year[0] = (i + 1).to_s
    end

    return @list_years

  end


  def rocklists_years_gather_qm(station, year)
    # WHFS  2000, 01, 02, 03!! Problem DONE

    @list_years = []
    doc_list = target_scrape("https://www.rocklists.com/#{station}-#{year}.html")
    info = doc_list.at('div.col-sm-12')
    info2 = info.css('p').try(:text).to_s()

    info3 = info2.force_encoding('iso8859-1').encode('utf-8')
    @info4 = info3.split("\n\n\t")

    @info4.each do |info|
      info = info.gsub(/(?:\d)(\. )/, ' - ')
      @list_years << info.split(/( - )/)
    end

    @list_years.each_with_index do |list_year, i|
      list_year.delete(' - ')
      list_year[0] = (i + 1).to_s
    end

    return @list_years

  end

  def rocklists_collections(station)
    # WHFS  2000, 01, 02, 03!! Problem DONE

    @list_years = []
    doc_list = target_scrape("https://www.rocklists.com/#{station}.html")
    info = doc_list.at('div.col-sm-12')
    info2 = info.css('p').try(:text).to_s()

    info3 = info2.force_encoding('iso8859-1').encode('utf-8')
    info3 = info3.gsub("7. Grandmaster Flash & Melle Mel - White Lines\n              \n              (Don\'t Do It)", "7. Grandmaster Flash & Melle Mel - White Lines (Don\'t Do It)")
    info3 = info3.gsub("The B-52â\u0080\u0099s", "The B-52's")
    info3 = info3.gsub("The B-52â\u0080\u0099S", "The B-52's")

    @info4 = info3.split("\n")

    @info4.each do |info|
      info.lstrip!
      puts info
      info = info.gsub(/(?:\d)(\. )/, ' - ')
      @list_years << info.split(/( - )/)
    end
    
    @list_years.each_with_index do |list_year, i|
      list_year.delete(' - ')
      list_year[0] = (i + 1).to_s
    end

    return @list_years

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

  def billboardtop100_to_1958(year)
    # ONLY 1940 works for this method and is DONE
    # 1940 to 1958
    # merge these with billboard wiki
    if year == "1940" 
      year = "336"
    end

    doc_list = target_scrape("http://billboardtop100of.com/#{year}-2")

    info = doc_list.css('div.entry-content')
    @year_list = []

    rows = info.css("p")
    info.css('p').each { |i| @year_list  << i.try(:text) }
    @year_list = @year_list[0].split("\n")
    @year_list = @year_list.map { |yl| yl.split(/\. | – /) }
  end

  def billboard_wiki(year)
    # 1946 to 2021 DONE
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
      yl[0], yl[1], yl[2] = yl[0], yl[2], yl[1]
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

    # rows_artist = rows.css("strong").text
    # rows_song = rows.css("h5").text


    # # these worked
    # rows_song = rows.at_css("h5").children.text
    # test = rows_song.gsub!("\n", '').strip
    # test = test.split(" - ")
    # map and strip





  end

    # other countdowns are not homogenous and may need special handling by station

end

# @year_list.each { |yl| yl.gsub!("\n\n\t", "") }
# @year_list.each { |yl| yl.gsub!("\n\n\n", "") }