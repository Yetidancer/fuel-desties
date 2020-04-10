class SearchController < ApplicationController
  def index

    conn = Faraday.new(url: 'https://developer.nrel.gov')
    response = conn.get('/api/alt-fuel-stations/v1/nearest.json?location=1331%2017th%20St%20LL100,%20Denver,%20CO%2080202&api_key=JpAFUzxbVWzL8ZfD5fzmFkbTLOkvqeCaMb0IBcsv&limit=1&fuel_type=ELEC')
    station_info = JSON.parse(response.body, symbolize_names: true)
    @station_name = station_info[:fuel_stations].first[:station_name]
    @station_address = station_info[:fuel_stations].first[:street_address]
    @station_city = station_info[:fuel_stations].first[:city]
    @station_state = station_info[:fuel_stations].first[:state]
    @station_zip = station_info[:fuel_stations].first[:zip]
    @station_fuel_type = station_info[:fuel_stations].first[:fuel_type_code]
    @station_access_times = station_info[:fuel_stations].first[:access_days_time]
    @station_distance = station_info[:fuel_stations].first[:distance]

    conn = Faraday.new(url: 'https://maps.googleapis.com')
    response = conn.get('/maps/api/directions/json?key=AIzaSyBaZ3TSjwDim_C4L8P1hphRQAa0wV0rhpQ&origin=1331%2017th%20St%20LL100,%20Denver,%20CO%2080202&destination=1225%2017th%20St%20LL100,%20Denver,%20CO%2080202')
    directions_info = JSON.parse(response.body, symbolize_names: true)
    @directions_distance = directions_info[:routes].first[:legs].first[:distance][:text]
    @directions_time = directions_info[:routes].first[:legs].first[:duration][:text]
    steps = directions_info[:routes].first[:legs].first[:steps]
    @directions_steps = steps.map { |step| step[:html_instructions] }
  end
end
