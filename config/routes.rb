Rails.application.routes.draw do

  root 'simulators#home'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :user, only: [:new, :create, :show]

  get '/simulators', to: 'simulators#calc'
  get '/simulators/under40', to: 'simulators#under40'
  get '/simulators/under43', to: 'simulators#under43'
  get '/simulators/result_nomatch', to: 'simulators#result_nomatch'
  get '/simulators/description', to: 'simulators#description'
  get '/simulators/result_under40', to: 'simulators#result_under40'
  get '/simulators/result_under43', to: 'simulators#result_under43'
  get 'simulators/send_mail', to: 'simulators#send_mail'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
