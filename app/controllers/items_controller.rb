class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id] 
      user = User.find_by!(id: params[:user_id])
      items = user.items
    else
      items = Item.all
    end
      render json: items, include: :user
  end

  def show
    item = Item.find_by!(id: params[:id])
    render json: item
  end

  def create 
    item = Item.create(user_id: params[:user_id], name: params[:name], price: params[:price], description: params[:description])
    render json: item, status: :created
  end

  private

  def render_not_found_response
    render json: { error: "Dog house not found" }, status: :not_found
  end

end
