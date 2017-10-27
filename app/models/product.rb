class Product < ApplicationRecord
	has_many :orders
	has_many :comments, dependent: :destroy

	validates :name, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.00}, :allow_blank => false
	

	def self.search(search_term)
    like_operator = Rails.env.development? ? 'like' : 'ilike'
    Product.where("name #{like_operator} ?", "%#{search_term}%")
  end


	def highest_rating_comment
  	comments.rating_desc.first
	end

	def lowest_rating_comment
  	comments.rating_asc.first
	end

	def average_rating
  	comments.average(:rating).to_f
	end

	def views
    # $redis.get("product:#{id}") # this is equivalent to 'GET product:1'
  end

  def viewed!
    # $redis.incrby("product:#{id}", 1) # this is equivalent to 'INC product:1'
  end

end
