require 'rest-client'
require 'json'
require 'pry'

def make_api_call(url)
  authorization_hash = {
    content_type: "application/json;charset=utf-8",
    authorization: "Bearer wN8RA0HKtqL58h7bBAP3-4K3UeZyceVHOB1AvTkvZ-s3bS-qBBCkv4nAyW0hrvhPJ0JQqd2QHOjo1ShuZfNDnCBzvuTsFAN3xppAclXNVS-rLxoQClnM3NmzSspgW3Yx"
  }
  response = RestClient.get url, headers = authorization_hash

  JSON.parse(response.body)
end

def get_restaurants(location, search_term = nil)
  search_term ? additional_search_term = "+#{search_term}" : additional_search_term = ""
  url = "https://api.yelp.com/v3/businesses/search?term=restaurants#{additional_search_term}&location=#{location}x&limit=10"
  make_api_call(url)
end

def get_resturant_info(yelp_business_id)
  url = "https://api.yelp.com/v3/businesses/#{yelp_business_id}"
  make_api_call(url)
end

def get_restaurant_reviews(yelp_business_id)
  url = "https://api.yelp.com/v3/businesses/#{yelp_business_id}/reviews"
  make_api_call(url)
end

def parse_restaurants(location, term)
  result = get_restaurants(location, term)
  business_array = result['businesses'].map do |h|
    {
      yelp_id: h['id'],
      name: h['name'],
      image_url: h['image_url'],
      categories: h['categories'][0]['title'],
      rating: h['rating'],
      address: h['location']['display_address'].join(', ')
    }
  end
end

def parse_reviews_and_customers(yelp_business_id)
  result = get_restaurant_reviews(yelp_business_id)['reviews']
  result.map do |h|
    {
      rating: h['rating'],
      text: h['text'],
      user: {
        name: h['user']['name'],
        profile_url: h['user']['profile_url'],
        image_url: h['user']['image_url']
      }
    }
  end
end
