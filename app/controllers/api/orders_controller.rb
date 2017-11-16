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
    startDate = params['start_date']
    endDate = params['end_date']
    range = params['range']
    customerId = order_params['customer_id']

    if(customerId)
      order = Order.find_by_customer_id(customerId)
    elsif(startDate && endDate && range)
      # Can be formatted in anyway date can be parsed. '15' or '11-15' or 'Nov 15, 2017' all works.
      startDate = Date.parse(params['start_date']).midnight
      endDate = Date.parse(params['end_date']).end_of_day
      result = {}
      date = startDate

      # endDate is exclusive. Eg. 15-17 will look for 15, 16th only.
      while(date <= endDate) do
        endRangeDate = range == 'day' ? date + 1.day : range == 'week' ? date + 1.week : date + 1.month
        order = Order.where(created_at: date..endRangeDate.midnight).includes(lineitems: :product)
        order.each do |o|
          o.lineitems.each do |li|
            product = li.product
            if(result[product.created_at.to_date])
              if result[product.created_at.to_date][product.name]
                result[product.created_at.to_date][product.name] += 1
              else
                result[product.created_at.to_date][product.name] = 1
              end
            else
              result[product.created_at.to_date] = {product.name => 1}
            end
          end
        end
        date = endRangeDate
      end
    else
      order = Order.all
    end

    if result
      render json: result
    elsif order
      render json: order
    elsif order.nil?
      render json: nil
    else
      render json: order.errors, status: 422
    end
  end

  def show
    order = Order.find_by_id(params[:id])
    if order
      render json: order
    elsif order.nil?
      render json: nil
    else
      render json: order.errors, status: 422
    end
  end

  def destroy
    order = Order.find_by_id(id: params[:id])
    if order && order.destroy
      render json: order
    elsif order.nil?
      render json: nil
    else
      render json: nil, status: 422
    end
  end

  def update
    order = Order.find_by_id(params[:id])
    if order.update_attributes(order_params)
      render json: order
    elsif order.nil?
      render json: nil
    else
      render json: order.errors.full_messages, status: 422
    end
  end

  private
  def order_params
    params.permit(:customer_id, :status)
  end
end
