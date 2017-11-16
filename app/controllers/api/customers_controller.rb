class Api::CustomersController < ApplicationController
  def index
    customers = Customer.all
    if customers
      render json: customers
    elsif customers.nil?
      render json: nil
    else
      render json: customers.errors, status: 422
    end
  end

  def show
    customer = Customer.find_by_id(params[:id])
    if customer
      render json: customer
    elsif customer.nil?
      render json: nil
    else
      render json: customer.errors, status: 422
    end
  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer
    else
      render json: customer.errors, status: 422
    end
  end

  def destroy
    customer = Customer.find_by_id(id: params[:id])
    if customer && customer.destroy
      render json: customer
    elsif customer.nil?
      render json: nil
    else
      render json: nil, status: 422
    end
  end

  def update
    customer = Customer.find_by_id(params[:id])
    if customer.update_attributes(customer_params)
      render json: customer
    elsif customer.nil?
      render json: nil
    else
      render json: customer.errors.full_messages, status: 422
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name)
  end
end
