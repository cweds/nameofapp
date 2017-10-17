class OrdersController < ApplicationController

	def index
    if params[:q]
      search_term = params[:q]
      @products = Product.search(search_term)
    else
      @products = Product.all
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  before_action :authenticate_user!


end