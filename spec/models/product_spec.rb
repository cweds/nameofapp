require 'rails_helper'

describe Product do

	let(:product) { Product.create!(name: "race bike") }

	user = FactoryGirl.build(:user)

	before do
	  product.comments.create!(rating: 1, user: user, body: "Awful bike!")
	  product.comments.create!(rating: 3, user: user, body: "Ok bike!")
	  product.comments.create!(rating: 5, user: user, body: "Great bike!")
	end

	it "returns the average rating of all comments" do
		expect(product.average_rating).to eq 3
	end

	it "returns the highest rating comment" do
		expect(product.highest_rating_comment.rating).to eq 5
	end

	it "returns the lowest rating comment" do
		expect(product.lowest_rating_comment.rating).to eq 1
	end
	
	context " validation test" do

		it "is not valid without a name" do
			expect(Product.new(name:nil)).not_to be_valid
		end
		
		it "is not valid without a description" do
			expect(Product.new(description:nil)).not_to be_valid
		end 

		it "is not valid without a color" do
			expect(Product.new(colour:nil)).not_to be_valid
		end 		

		it "is not valid without a price" do
			expect(Product.new(price:nil)).not_to be_valid
		end 

		it "is not valid without a image" do
			expect(Product.new(image_url:nil)).not_to be_valid
		end 
		
	end

end