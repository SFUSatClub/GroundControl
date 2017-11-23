namespace :fetch_api do

  desc 'Seed the database API data from NORAD'
  task :seed_db => :environment do
    load_requirements

    log = ActiveSupport::Logger.new('log/fetch_api.log')
    start_time = Time.now
    # sat_count = Satellites.count
    log.info "Task started at #{start_time}"

    file = open('https://www.celestrak.com/NORAD/elements/galileo.txt')
    contents = file.read
    contents.gsub!(/\r\n?/, "\n")
    data = contents.split("\n")

    groupsats = Array.new

    data.each_slice(3){ |onesat|
      groupsats << onesat
    }

    groupsats.each { |satrecord|
    # add each record to database 0 = name, 1 = TLE 1, 2 = TLE 2

      storein_db satrecord

    }

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
    log.close

  end

  def load_requirements
    require 'open-uri'
  end

  def storein_db(records)

    # p records[0]
    # p records[1]
    # p records[2]
    # Satellite.find_or_create_by(name: records[0])

    # p Satellite.create(name: records[0], category: 'Navigation Satellites', tle1: records[1], tle2: records[2])

    thesat = Satellite.find_or_initialize_by(name: records[0])

    if thesat.new_record?  #if it is new then just save it      
      thesat.save
    else  #if it allready exists overwrite the parameters for it
      thesat.tle1 = records[1]
      thesat.tle2 = records[2]
      thesat.save
    end

  end

end
