Rails.application.routes.draw do
  scope :v1 do
    resources :quotes, only: [:show, :create]
  end
end
