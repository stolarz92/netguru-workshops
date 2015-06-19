class ProductsController < ApplicationController
  before_action :signed_in, only: [:create, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    self.product = Product.new(product_params)
    self.product.user_id = current_user.id if current_user

    if product.save
      category.products << product
      flash[:success] = 'Product was successfully added.'
      redirect_to category_product_url(category, product)
    else
      render action: 'new'
    end
  end

  def update
    if self.product.update(product_params)
      flash[:success] = 'Product was successfully updated.'
      redirect_to category_product_url(category, product)
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private
  def signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end

  def correct_user
    unless product.user == current_user
      redirect_to(category_product_url(category, product), flash: {error: 'You are not allowed to edit this product.'})
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
