class Api::ProductsController < ApplicationController
  def create
    product = Product.new(product_params)
    if product.save
      render json: product
    else
      render json: product.errors, status: 422
    end
  end

  def index
    product = Product.all
    if product
      render json: product
    else
      render json: product.errors, status: 422
    end
  end

  def show
    product = Product.find_by_id(params[:id])
    if product
      render json: product
    else
      render json: product.errors, status: 422
    end
  end

  def destroy
    product = Product.find_by_id(id: params[:id])
    if product && product.destroy
      render json: product
    else
      render json: nil, status: 422
    end
  end

  def update
    product = Product.find_by_id(params[:id])
    if product.update_attributes(product_params)
      render json: product
    else
      render json: product.errors.full_messages, status: 422
    end
  end


  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
