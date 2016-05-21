Rails.application.routes.draw do
  resources :questions do
	collection do
        get ":id/question"  => "questions#question", :as => :question		
		post "answer/:id"  => "questions#answer", :as => :answer
      end
  end
  

end
