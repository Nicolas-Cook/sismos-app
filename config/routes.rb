# Rails.application.routes.draw do
#   namespace :api do
#       resources :features, only: [:index] do
#         post 'comments', to: 'features#create_comment'
#       end
#   end
# end
Rails.application.routes.draw do
  namespace :api do
    resources :features, only: [:index] do
      resources :comments, only: [:create], controller: 'features'
    end
  end
end