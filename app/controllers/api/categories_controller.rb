class Api::CategoriesController < ApplicationController
  def create
    category = Category.new(category_params)
    if category.save
      render json: category
    else
      render json: category.errors, status: 422
    end
  end

  def index
    category = Category.all
    if category
      render json: category
    else
      render json: category.errors, status: 422
    end
  end

  def show
    category = Category.find_by_id(params[:id])
    if category
      render json: category
    else
      render json: category.errors, status: 422
    end
  end

  def destroy
    category = Category.find_by_id(id: params[:id])
    if category && category.destroy
      render json: category
    else
      render json: nil, status: 422
    end
  end

  def update
    category = Category.find_by_id(params[:id])
    if category.update_attributes(category_params)
      render json: category
    else
      render json: category.errors.full_messages, status: 422
    end
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end
end
