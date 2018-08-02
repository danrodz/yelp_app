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
  binding.pry
  # tentative menu?
  show_message('menu')
  show_message('1 - Address')
  show_message('2 - Reviews')
  show_message('3 - Rating')
  show_message('4 - Categories')
  show_message('5 - Images')
  show_message('6 - customers')
  # return number with selection to choose query type
  selection = take_integer
  { selection: selection, restaurant_id: new_restaurant.id }
end

def run_query(selection:, restaurant_id:)
  case
  when selection == 1
    # tentative for address
  when selection == 2
    # tentative for reviews
  when selection == 3
    # tentative for rating?
  when selection == 4
    # tentative for categories?
  when selection == 5
    # tentative for images?
  else
    # tentative for customers?
  end
end

def welcome
  show_message('Hello There!')
  show_message('To begin your restaurant search, please provide the location or city')
  location = take_string
  show_message('Would you like to search for a specific item / cuisine / term / etc ? (Yes / No)')
  yes_or_no = take_string
  term = provided_term(yes_or_no)
  show_message("Great! Let's begin")
  show_message('Loading your results!')
  yelp_id = display_restaurants(location, term)
  selection_and_restaurant_id = display_menu(yelp_id)
  run_query(selection_and_restaurant_id)
end

# welcome
