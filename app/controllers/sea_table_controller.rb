class SeaTableController < ApplicationController
  def index
    base_info = SeatableRuby::BasicInfo.new.basic_info.with_indifferent_access

    if base_info[:tables]
      expenses_table = base_info[:tables].find { |table| table[:name] == 'Expenses' }
      @expenses = expenses_table[:rows].map do |expense|
        {
          reason: expense['0000'],
          date: expense['9yXx'],
          amount: expense['9m23']
        }
      end
    else
      @expenses = []
      flash[:alert] = "Les données de la base n'ont pas pu être récupérées."
    end
  end
end
