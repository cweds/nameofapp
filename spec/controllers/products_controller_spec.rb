
require 'rails_helper'

#index
describe ProductsController, type: :controller do
  context 'GET #index' do
    it 'renders the index page' do 
      get :index
      expect(response).to be_ok
      expect(response).to render_template('index')
    end
  end

  #show
  context 'GET #show' do
    it 'renders the show page' do 
      @product = FactoryGirl.create(:product)
      get :show, params: {id: @product}
      expect(response).to be_ok
      expect(response).to render_template('show')
    end
  end  

  # Create
  context "POST #create" do
    before do 
      @user = FactoryGirl.build(:user)
      sign_in @user
    end
    it "successfully creates new product" do  
      @product = FactoryGirl.create(:product)
      expect(response).to be_successful
    end
    it "cannot create a product" do 
       expect(Product.new(price:nil)).not_to be_valid
    end  
  end  

  #update
  context "put #update" do
    before do 
      @product = FactoryGirl.create(:product)
      @user = FactoryGirl.build(:user)
      sign_in @user
    end
    it "successfully updates a product" do
      @update = { name:@product.name, image_url:"ex.com", id:@product.id, price:@product.price, color: "brown"}
      put :update, params: { id: @product.id, product: @update}
      @product.reload
      expect(@product.color).to eq "blue"
    end
  end

  #delete
  context "delete" do 
    before do 
      @product = FactoryGirl.create(:product)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "allows admin to delete a product" do 
      delete :destroy, params: {id: @product}
      expect(response).to redirect_to products_path
    end
  end 
end