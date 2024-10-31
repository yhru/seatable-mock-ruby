# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'sea_table#index'

  resources :sea_table, only: [:index, :destroy] do
    collection do
      get :new_expense
      post :create_expense
      get :autocomplete
    end
  end
end
