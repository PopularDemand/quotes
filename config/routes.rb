Rails.application.routes.draw do
  scope :v1 do
    get 'quotes/random', to: 'quotes#random'
    resources :quotes, only: [:show, :create, :update, :index]
  end
end
