Rails.application.routes.draw do

  namespace :api do
    resources :customers, except: [:edit, :new]
    resources :orders, except: [:edit, :new]
    resources :categories, except: [:edit, :new]
    resources :products, except: [:edit, :new]
    resources :lineitems, except: [:edit, :update, :new]
  end
end
