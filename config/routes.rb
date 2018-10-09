Rails.application.routes.draw do

  devise_for :users

  resources :user, only: [:new, :create, :show]
  resources :simulator

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
