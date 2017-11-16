class Api::OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      render json: order
    else
      render json: order.errors, status: 422
    end
  end

  def index
    order = Order.all
    if order
      render json: order
    else
      render json: order.errors, status: 422
    end
  end

  def show
    order = Order.find_by_id(params[:id])
    if order
      render json: order
    else
      render json: order.errors, status: 422
    end
  end

  def destroy
    order = Order.find_by_id(id: params[:id])
    if order && order.destroy
      render json: order
    else
      render json: nil, status: 422
    end
  end

  def update
    order = Order.find_by_id(params[:id])
    if order.update_attributes(order_params)
      render json: order
    else
      render json: order.errors.full_messages, status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :status)
  end
end
