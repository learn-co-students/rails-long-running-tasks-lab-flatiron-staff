Rails.application.routes.draw do
  resources :artists, :songs

  post '/upload', to: 'songs#upload'
end
