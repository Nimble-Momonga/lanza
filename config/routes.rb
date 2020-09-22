Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'application#index'

  mount Sidekiq::Web, at: 'sidekiq'
end
