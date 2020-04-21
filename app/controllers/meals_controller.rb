class MealsController < ApplicationController

  def details
    @order = Order.where(id: params[:id]).first
    @meals = Meal.where(order: params[:id])
  end

  def addMeal
    @meal = Meal.new(meal_params)
    @meal.order = params[:id]
    if (@meal.save)
      @meals = Meal.where(order: params[:id])
      render 'details'
    else
      @meals = Meal.where(order: params[:id])
      render 'details'
    end
  end

  private def meal_params
    params.require(:addMeal).permit(:person, :meal, :amount, :price, :comment, :order)
  end
end
