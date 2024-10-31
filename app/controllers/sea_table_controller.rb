# frozen_string_literal: true

class SeaTableController < ApplicationController
  def index
    base_info = SeatableRuby::BasicInfo.new.basic_info.with_indifferent_access
    expenses_table = base_info[:tables]&.find { |table| table[:name] == 'Expenses' }

    @expenses = if expenses_table
                  expenses_table[:rows].map do |expense|
                    { 
                      id: expense['_id'],
                      reason: expense['0000'],
                      date: expense['9yXx'],
                      amount: expense['9m23'] 
                    }
                  end
                else
                  []
                end
    flash[:alert] = "Les données de la base n'ont pas pu être récupérées." if @expenses.empty?
  end

  def new_expense; end

  def create_expense
    row_data = {
      'Reason' => params[:expense_name],
      'Date' => params[:expense_date],
      'Amount' => params[:expense_amount].to_f
    }

    row_api = SeatableRuby::Row.new(api_token: ENV['SEATABLE_BASE_TOKEN'])
    response = row_api.append_row(table_name: 'Expenses', row: row_data)

    if response && response['_id']
      redirect_to sea_table_index_path, notice: 'Dépense ajoutée avec succès'
    else
      flash[:alert] = "Erreur lors de l'ajout de la dépense."
      render :new_expense
    end
  end

  def destroy
    row_id = params[:id]
    Rails.logger.info "Tentative de suppression de la dépense avec ID : #{row_id}"
    row_api = SeatableRuby::Row.new(api_token: ENV['SEATABLE_BASE_TOKEN'])
    response = row_api.delete_row(table_name: 'Expenses', row_id: row_id)

    if response
      redirect_to sea_table_index_path, notice: 'Dépense supprimée avec succès'
    else
      flash[:alert] = "Erreur lors de la suppression de la dépense."
      redirect_to sea_table_index_path
    end
  end

  def autocomplete
    query = params[:q].downcase
    base_info = SeatableRuby::BasicInfo.new.basic_info.with_indifferent_access
    expenses_table = base_info[:tables]&.find { |table| table[:name] == 'Expenses' }

    results = if expenses_table
                expenses_table[:rows].filter_map do |row|
                  row['0000'] if row['0000']&.downcase&.include?(query)
                end
              else
                []
              end

    render json: results.uniq
  end
end
