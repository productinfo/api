Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'webhooks/github', to: 'webhooks#github'
  get 'zen', to: 'zen#show'
  get 'contributors', to: 'github#contributors'
  get 'projects', to: 'github#projects'
end
