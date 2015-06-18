class ReviewsController < ApplicationController

  expose(:review)
  expose(:product)

  def edit
  end

  def create
    self.review = Review.new(review_params)
    self.review.user = current_user

    if review.save
      flash[:success] = 'Review was successfully added.'
      product.reviews << review
      redirect_to category_product_url(product.category, product)
    else
      render action: 'new'
    end
  end

  def destroy
    review.destroy
    flash[:success] = 'Review was successfully destroyed.'
    redirect_to category_product_url(product.category, product)
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
