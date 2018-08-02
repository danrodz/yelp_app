class Review < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  # attr_reader :rating, :text, :customer_id, :business_id, :yelp_id

  # def initialize(info)
  #   binding.pry
  #   super(info)
  #   @rating = info["rating"]
  #   @text = info["text"]
  #   @customer_id = Customer.create(info["user"]).id
  #   @business_id = Business.find_by(yelp_id: yelp_id)
  # end

  # def add_business_and_customer_ids(info, yelp_id)
  #   @business_id = Business.find_by(yelp_id: yelp_id)
  #   @customer_id = Customer.create(info["user"]).id
  #   self.save
  # end
end
