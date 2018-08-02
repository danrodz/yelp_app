def take_string
  gets.chomp.downcase
end

def take_integer
  gets.chomp.to_i
end

def show_message(message)
  puts
  puts message
  puts
end

def provided_term(term)
  if term == 'no'
    return nil
  else
    show_message('Please provide your additional search term!')
    return take_string
  end
end

def display_restaurants(location, term)
  list = parse_restaurants(location, term)

  list.each.with_index(1) do |h, i|
    show_message("#{i} - #{h[:name]} - Rating: #{h[:rating]}")
  end

  list.map { |restaurant| Restaurant.create(restaurant) }

  show_message('Please choose the number of the restaurant you will like to view.')
  index = take_integer

  unless index > 0 && index <= list.length
    show_message('Please provide a valid selection')
    index = take_integer
  end

  list[index - 1][:yelp_id]
end

def display_menu(yelp_id)
  new_restaurant = Restaurant.find_by(yelp_id: yelp_id)
  review_info = parse_reviews_and_customers(yelp_id)

  review_info.each do |hash|
    user_id = Customer.create(hash[:user]).id
    restaurant_id = new_restaurant.id
    rating = hash[:rating]
    text = hash[:text]
    Review.create({rating: rating, text: text, customer_id: user_id, restaurant_id: restaurant_id})
  end

  show_message('menu')
  show_message('1 - Address')
  show_message('2 - Reviews')
  show_message('3 - Rating')
  show_message('4 - Categories')
  show_message('5 - Images')
  show_message('6 - customers')
  selection = take_integer
  { selection: selection, restaurant_id: new_restaurant.id }
end

def run_query(selection:, restaurant_id:)
  case
  when selection == 1
    # tentative for address
    p Restaurant.find_by(restaurant_id: restaurant_id).address
  when selection == 2
    # tentative for reviews
    p Review.all.select { |review| review.restaurant_id == restaurant_id }
  when selection == 3
    # tentative for rating?
    p Restaurant.find_by(restaurant_id: restaurant_id).rating
  when selection == 4
    # tentative for categories?
    p Restaurant.find_by(restaurant_id: restaurant_id).categories
  when selection == 5
    # tentative for images?
    p Restaurant.find_by(restaurant_id: restaurant_id).images
  else
    binding.pry
    p Review.all.map { |review| review.customer if review.restaurant_id == new_restaurant }.compact!
    # tentative for customers?
  end
end

def welcome
  show_message('Hello There!')
  show_message('To begin your restaurant search, please provide the location or city')
end

def display_loading
  show_message("Great! Let's begin")
  show_message('Loading your results!')
end

def get_location_and_term
  location = take_string
  show_message('Would you like to search for a specific item / cuisine / term / etc ? (Yes / N)')
  yes_or_no = take_string
  term = provided_term(yes_or_no)
  # returns the location and additional searching term
  { location: location, term: term }
end

def fetch_restaurants(location:, term:)
  # return yelps id
  display_restaurants(location, term)
end

def get_menu_and_query(yelp_id)
  selection_and_restaurant_id = display_menu(yelp_id)
  run_query(selection_and_restaurant_id)
end

initialized = true

while initialized
  in_welcome = true
  in_location = true
  in_restaurants = true
  in_menu_and_query = true
  in_additional_query = false
  in_exit_message = false
  location_and_term = nil
  yelp_id = nil

  while in_welcome
    welcome
    in_welcome = false
  end

  while in_location
    location_and_term = get_location_and_term
    in_location = false if location_and_term
  end

  while in_restaurants
    yelp_id = fetch_restaurants(location_and_term)
    in_restaurants = false if yelp_id
  end

  while in_menu_and_query
    get_menu_and_query(yelp_id)
    in_additional_query = true
    in_menu_and_query = false
  end

  while in_additional_query
    show_message('Would you like to see something else about this restaurant? (Yes, No)')
    additional_query = take_string
    in_additional_query = false

    if additional_query.downcase == 'no'
      in_exit_message = true
    else
      in_menu_and_query = true
    end
  end

  while in_exit_message
    show_message('Until next time!')
    in_exit_message = false
    initialized = false
  end
end
