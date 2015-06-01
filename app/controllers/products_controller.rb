class ProductsController < ApplicationController
  before_action :signed_in, only: [:create, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
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

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if self.product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
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
    owner = product.user
    if owner != current_user
      flash[:error] = 'You are not allowed to edit this product.'
      redirect_to category_product_path(category, product)
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
