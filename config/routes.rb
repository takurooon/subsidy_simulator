Rails.application.routes.draw do

  root 'simulators#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users

  resources :user, only: [:new, :create, :show]

  get '/simulators', to: 'simulators#index'

  get 'simulators/under40' => 'simulators/under40'
  get 'simulators/under43' => 'simulators/under43'
  post 'simulators/result_under40' => 'simulators/result_under40'
  post 'simulators/result_under43' => 'simulators/result_under43'

  get 'simulators/send_mail' => 'simulators/send_mail'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
