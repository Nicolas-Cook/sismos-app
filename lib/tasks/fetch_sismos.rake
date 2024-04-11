require 'open-uri'
require 'json'

namespace :fetch do
    task features: :environment do
  
      url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
      file = URI.open(url).read
      data = JSON.parse(file)
  
      data['features'].each do |feature|
        properties = feature['properties']
        geometry = feature['geometry']
  
        # Validar los datos antes de persistir
        next if properties['title'].nil? || properties['url'].nil? || properties['place'].nil? || properties['magType'].nil? || geometry['coordinates'].nil?
        next if properties['mag'] < -1.0 || properties['mag'] > 10.0
        next if geometry['coordinates'][0] < -180.0 || geometry['coordinates'][0] > 180.0
        next if geometry['coordinates'][1] < -90.0 || geometry['coordinates'][1] > 90.0

        # Formatear data
        formatted_data = {
          "type" => "feature",
          "attributes" => {
            "external_id" => feature['id'],
            "magnitude" => properties['mag'].to_f,
            "place" => properties['place'],
            "time" => Time.at(properties['time'] / 1000).to_s,
            "tsunami" => properties['tsunami'] == 1,
            "mag_type" => properties['magType'],
            "title" => properties['title'],
            "coordinates" => {
              "longitude" => geometry['coordinates'][0].to_f,
              "latitude" => geometry['coordinates'][1].to_f
            }
          },
          "links" => {
            "external_url" => properties['url']
          }
          
        }
        
  
        # Persistir los datos en la base de datos
        Feature.create(data: formatted_data)
      end
    end
end