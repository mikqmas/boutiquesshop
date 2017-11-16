class Api::LineitemsController < ApplicationController
  def create
    lineitem = Lineitem.new(lineitem_params)
    if lineitem.save
      render json: lineitem
    else
      render json: lineitem.errors, status: 422
    end
  end

  def index
    lineitem = Lineitem.all
    if lineitem
      render json: lineitem
    else
      render json: lineitem.errors, status: 422
    end
  end

  def show
    lineitem = Lineitem.find_by_id(params[:id])
    if lineitem
      render json: lineitem
    else
      render json: lineitem.errors, status: 422
    end
  end

  def destroy
    lineitem = Lineitem.find_by_id(id: params[:id])
    if lineitem && lineitem.destroy
      render json: lineitem
    else
      render json: nil, status: 422
    end
  end

  private
  def lineitem_params
    params.require(:lineitem).permit(:product_id, :order_id)
  end
end
