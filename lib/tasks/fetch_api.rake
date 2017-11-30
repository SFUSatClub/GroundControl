namespace :fetch_api do

  desc 'Seed the database API data from NORAD'
  task :seed_db => :environment do
    load_requirements

    log = ActiveSupport::Logger.new('log/fetch_api.log')
    start_time = Time.now
    # sat_count = Satellites.count
    log.info "Task started at #{start_time}"

    #######################################################################
    ################     HARD CODED LINKS FROM NORAD     ##################
    #######################################################################

    ################     Special-Interest Satellites     ##################

    specialsats = ["https://www.celestrak.com/NORAD/elements/tle-new.txt",
                   "https://www.celestrak.com/NORAD/elements/stations.txt",
                   "https://www.celestrak.com/NORAD/elements/visual.txt",
                   "https://www.celestrak.com/NORAD/elements/1999-025.txt",
                   "https://www.celestrak.com/NORAD/elements/iridium-33-debris.txt",
                   "https://www.celestrak.com/NORAD/elements/cosmos-2251-debris.txt",
                   "https://www.celestrak.com/NORAD/elements/2012-044.txt"]

    ################     Weather & Earth Resources Satellites ############

    weathersats = ["https://www.celestrak.com/NORAD/elements/weather.txt",
                   "https://www.celestrak.com/NORAD/elements/noaa.txt",
                   "https://www.celestrak.com/NORAD/elements/goes.txt",
                   "https://www.celestrak.com/NORAD/elements/resource.txt",
                   "https://www.celestrak.com/NORAD/elements/sarsat.txt",
                   "https://www.celestrak.com/NORAD/elements/dmc.txt",
                   "https://www.celestrak.com/NORAD/elements/tdrss.txt",
                   "https://www.celestrak.com/NORAD/elements/argos.txt"]

    ################     Communications Satellites #######################

    commsats = ["https://www.celestrak.com/NORAD/elements/geo.txt",
                "https://www.celestrak.com/NORAD/elements/intelsat.txt",
                "https://www.celestrak.com/NORAD/elements/ses.txt",
                "https://www.celestrak.com/NORAD/elements/iridium.txt",
                "https://www.celestrak.com/NORAD/elements/iridium-NEXT.txt",
                "https://www.celestrak.com/NORAD/elements/orbcomm.txt",
                "https://www.celestrak.com/NORAD/elements/globalstar.txt",
                "https://www.celestrak.com/NORAD/elements/amateur.txt",
                "https://www.celestrak.com/NORAD/elements/x-comm.txt",
                "https://www.celestrak.com/NORAD/elements/other-comm.txt",
                "https://www.celestrak.com/NORAD/elements/gorizont.txt",
                "https://www.celestrak.com/NORAD/elements/raduga.txt",
                "https://www.celestrak.com/NORAD/elements/molniya.txt"]

    ################     Navigation Satellites #########################

    navsats = ["https://www.celestrak.com/NORAD/elements/gps-ops.txt",
              "https://www.celestrak.com/NORAD/elements/glo-ops.txt",
              "https://www.celestrak.com/NORAD/elements/beidou.txt",
              "https://www.celestrak.com/NORAD/elements/sbas.txt",
              "https://www.celestrak.com/NORAD/elements/nnss.txt",
              "https://www.celestrak.com/NORAD/elements/musson.txt",
              "https://www.celestrak.com/NORAD/elements/galileo.txt"]

    ################     Scientific Satellites #########################

    sciencesats = ["https://www.celestrak.com/NORAD/elements/science.txt",
                   "https://www.celestrak.com/NORAD/elements/geodetic.txt",
                   "https://www.celestrak.com/NORAD/elements/engineering.txt",
                   "https://www.celestrak.com/NORAD/elements/education.txt"]

    ################     Miscellaneous Satellites ######################

    miscsats = ["https://www.celestrak.com/NORAD/elements/military.txt",
                "https://www.celestrak.com/NORAD/elements/radar.txt",
                "https://www.celestrak.com/NORAD/elements/cubesat.txt",
                "https://www.celestrak.com/NORAD/elements/other.txt"]

    #######################################################################
    ################   END OF HARD CODED LINKS FROM NORAD #################
    #######################################################################

    specialsats.each do |sat|
        get_category_link_contents(sat,"Special-Interest Satellites")
    end

    # weathersats.each do |sat|
    #     get_category_link_contents(sat,"Weather & Earth Resources Satellites")
    # end
    #
    # commsats.each do |sat|
    #     get_category_link_contents(sat,"Communications Satellites")
    # end
    #
    # navsats.each do |sat|
    #     get_category_link_contents(sat,"Navigation Satellites")
    # end
    #
    # sciencesats.each do |sat|
    #     get_category_link_contents(sat,"Scientific Satellites")
    # end
    #
    # miscsats.each do |sat|
    #     get_category_link_contents(sat,"Miscellaneous Satellites")
    # end

    end_time = Time.now
    duration = (start_time - end_time) / 1.minute
    log.info "Task finished at #{end_time} and last #{duration} minutes."
    log.close

  end


  def load_requirements
    require 'open-uri'
  end


  def get_category_link_contents(link, category)

    file = open(link)

    begin
      contents = file.read
      contents.gsub!(/\r\n?/, "\n")
      data = contents.split("\n")

      groupsats = Array.new

      data.each_slice(3){ |onesat|
        groupsats << onesat
      }

      groupsats.each { |satrecord|
      # add each record to database 0 = name, 1 = TLE 1, 2 = TLE 2
        # p category
        storein_db(satrecord,category)
      }
    ensure
      file.close
    end


    p link


  end

  def storein_db(records, category)
    # p records[0]
    # p records[1]
    # p records[2]
    # p category
    # Satellite.find_or_create_by(name: records[0])
    # p Satellite.create(name: records[0], category: 'Navigation Satellites', tle1: records[1], tle2: records[2])
    Satellite.find_or_create_by(name: records[0], category: category, tle1: records[1], tle2: records[2])
  end
end
