class PaymentsController < ApplicationController

	def create

		# Create variable to find the instance variable in the hidden field of _strip_checkout
  	@product = Product.find(params[:product_id])
	  
  	if user_signed_in?
     @user = current_user
    else
      redirect_to new_user_registration_path
  	end

	  token = params[:stripeToken]

	  # Create the charge on Stripe's servers - this will charge the user's card
	  begin
	    charge = Stripe::Charge.create(
	      amount: @product.price * 100, # amount in cents, again
	      currency: "usd",
	      source: token,
	      description: @product.name,
	      receipt_email: @user.email,
	    )

	  if charge.paid
  		Order.create(
  			product_id: params[:product_id],
  			user_id: @user.id,
        total: @product.price * 100,
  		)
		end

	  rescue Stripe::CardError => e
	    # The card has been declined
	    body = e.json_body
    	err = body[:error]
    	flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
	  end

	  redirect_to static_pages_payment_thank_you_path

	end


end
