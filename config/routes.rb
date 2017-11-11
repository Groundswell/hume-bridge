Rails.application.routes.draw do

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :data, only: [ :index, :create ] do
		get :twod, on: :collection
		get :tag_new_with, on: :collection
	end

end
