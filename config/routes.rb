GyazoS3::Application.routes.draw do
  root 'items#index'

  get    '/:name.:format' => 'items#show',    format: /png|gif|jpe?g/
  delete '/:name.:format' => 'items#destroy', format: /png|gif|jpe?g/
  post   '/items'         => 'items#create'

end
