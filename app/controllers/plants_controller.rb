class PlantsController < ApplicationController
  def index
    plants = Plant.all
    render json: plants
  end

  def show
    plant = Plant.find(params[:id])
    render json: plant
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Plant not found' }, status: :not_found
  end

  def create
    plant = Plant.create(plant_params)
    if plant.valid?
      render json: plant, status: :created
    else
      render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    plant = Plant.find(params[:id])
    if plant.update(plant_params)
      render json: plant
    else
      render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Plant not found' }, status: :not_found
  end

  def destroy
    plant = Plant.find(params[:id])
    plant.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Plant not found' }, status: :not_found
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :image, :price, :is_in_stock)
  end
end
