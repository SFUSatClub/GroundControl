namespace :fetch_api do

  desc 'Seed the database API data from NORAD'
  task seed_db: :environment do
    load_requirements
    file = open('https://www.celestrak.com/NORAD/elements/galileo.txt')
    contents = file.read
    contents.gsub!(/\r\n?/, "\n")
    data = contents.split("\n")
    # data is now saved into data array, accessed 3 elements at a time

    groupsats = Array.new

    data.each_slice(3){ |onesat|
      groupsats << onesat
    }

    groupsats.each { |satrecord|
    # add each record to database 0 = name, 1 = TLE 1, 2 = TLE 2
      p satrecord[0]
      p satrecord[1]
      p satrecord[2]
    }


  end

  def load_requirements
    require 'open-uri'
  end
end
