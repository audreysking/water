Rails.application.routes.draw do
  root 'waters#index'
  get  'waters/search'  =>  'waters#search'
end
