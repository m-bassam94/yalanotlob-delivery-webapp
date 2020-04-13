class MealsController < ApplicationController
    
    def details
    end
    
    def addMeal
        @meal = Meal.new(meal_params)
        @meal.order = params[:id]
        if(@meal.save)
            render 'details'
        end        
    end

    private def meal_params
        params.require(:addMeal).permit(:person, :meal, :amount, :price, :comment, :order)
    end
end
