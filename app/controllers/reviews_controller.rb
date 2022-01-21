class ReviewsController < ApplicationController

  before_action :get_review, only: [:edit, :update, :destroy]

  def new
    @list = List.find(params[:list_id])
    @review = Review.new(list: @list)
  end

  def create
    @review = Review.create(review_params)
    @list = List.find(params[:list_id])
    @review.list = @list

    if @review.save
      redirect_to list_path(@list)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @review.update(review_params)

    redirect_to list_path(@review.list)
  end

  def destroy
    @review.destroy

    redirect_to list_path(@review.list)
  end

  private

  def get_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
