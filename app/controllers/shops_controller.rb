require 'rubygems'
require 'geokit'
Geokit::default_units = :kms
class ShopsController < ApplicationController

  def nearest
    user_latitude = params[:latitude]
    user_longitude = params[:longitude]
    user_medicine = params[:medicine]
    required_shops = Shop.includes(:medicines).where('medicines.name' => user_medicine)
    least_distance = 1000000
    current_distance = 0
    nearest_shop = Shop.first
    required_shops.each_with_index do |shop, index|
      current_distance=calculate(user_latitude, user_longitude, shop.lon, shop.lat)
      if(current_distance < least_distance)
        least_distance = current_distance
        nearest_shop = shop
        nearest_shop[:distance] = least_distance
      end
    end

    all_shops = []
    required_shops.each_with_index do |shop, index|
      shop[:distance] = calculate(user_latitude, user_longitude, shop.lon, shop.lat)
      all_shops.push(shop)
    end

    all_shops.sort_by! do |item|
      item[:distance]
    end

    data = {
      name: nearest_shop.name,
      distance: nearest_shop.distance,
      unit: Geokit::default_units,
      address: nearest_shop.address,
      alternate: [
        'Medicine31',
        'Medicine24',
        'Medicine11',
        'Medicine43'
      ],
      cordinates: {
        latitude: nearest_shop.lat,
        longitude: nearest_shop.lon
      },
      all_shops: all_shops.all
      medicine: user_medicine,
      medicines_at_shop: nearest_shop.medicines.all,
      available_shops: required_shops.all
    }
      render :json => data
  end

  private
  def calculate(friend_latitude, friend_longitude, office_latitude, office_longitude)
    office_location = Geokit::LatLng.new(office_latitude, office_longitude)
    friends_location = "#{friend_latitude},#{friend_longitude}"
    return office_location.distance_to(friends_location)
  end

end
