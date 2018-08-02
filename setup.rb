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

  list.map { |restaurant| Restaurant.find_or_create_by(restaurant) }

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
    user_id = Customer.find_or_create_by(hash[:user]).id
    restaurant_id = new_restaurant.id
    rating = hash[:rating]
    text = hash[:text]
    Review.find_or_create_by({rating: rating, text: text, customer_id: user_id, restaurant_id: restaurant_id})
  end

  show_message('menu')
  show_message('1 - Address')
  show_message('2 - Reviews')
  show_message('3 - Rating')
  show_message('4 - Categories')
  show_message('5 - Images Urls')
  show_message('6 - customers')
  selection = take_integer
  { selection: selection, restaurant_id: new_restaurant.id }
end

def run_query(selection:, restaurant_id:)
  restaurant = Restaurant.find_by(id: restaurant_id)
  case 
  when selection == 1
    show_message("This restaurant is located at : #{restaurant.address}")
  when selection == 2
    restaurant.reviews.each do |review|
      puts ''
      puts "Rating: #{review.rating}"
      puts "Comment: #{review.text}"
      puts "Customer: #{review.customer.name}"
      puts ''
    end
  when selection == 3
    show_message("Restaurant Rating: #{restaurant.rating}")
  when selection == 4
    show_message("This Restaurant's Categories are: #{restaurant.categories}")
  when selection == 5
    show_message(restaurant.image_url)
  else
    show_message('')
    restaurant.customers.each.with_index(1) { |c, i| puts "#{i} - #{c.name}" }
    show_message('')
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

def run
  initialized = true
  location_and_term = nil
  yelp_id = nil
  in_welcome = true
  in_menu_and_query = false
  in_additional_query = false

  while initialized
    in_location = false
    in_restaurants = false
    in_exit_message = false

    while in_welcome
      welcome
      in_welcome = false
      in_location = true
    end

    while in_location
      location_and_term = get_location_and_term
      in_location = false if location_and_term
      in_restaurants = true
    end

    while in_restaurants
      yelp_id = fetch_restaurants(location_and_term)
      in_restaurants = false if yelp_id
      in_menu_and_query = true
    end

    while in_menu_and_query
      get_menu_and_query(yelp_id)
      in_additional_query = true
      in_menu_and_query = false
    end

    while in_additional_query
      show_message('Would you like to see something else about this restaurant? (Yes, No)')
      additional_query = take_string
      if additional_query == 'no'
        in_exit_message = true
      else
        in_menu_and_query = true
      end
      in_additional_query = false
    end

    while in_exit_message
      show_message('Until next time!')
      in_exit_message = false
      initialized = false
    end
  end
end
