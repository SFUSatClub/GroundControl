namespace :fetch_api do

  desc 'Seed the database API data from NORAD'
  task seed_db: :environment do
    load_requirements
    file = open('https://www.celestrak.com/NORAD/elements/galileo.txt')
    contents = file.read
    contents.gsub!(/\r\n?/, "\n")
    data = contents.split("\n")
    # data is now saved into data array, accessed 3 elements at a time
    p data

  end

  def load_requirements
    require 'open-uri'
  end
end
