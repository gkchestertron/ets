class XHRConstraint
    def matches?(request)
        !request.xhr?
    end
end

class IsItABot
    def matches?(request)
        user_agent = request.user_agent.downcase
        @bot = [ 'msnbot', 'yahoo! slurp','googlebot' ].detect { |bot| user_agent.include? bot }
        !!@bot
    end
end

Rails.application.routes.draw do
    post '/sessions' => 'sessions#create'
    delete '/sessions' => 'sessions#destroy'

    #check for bots -> don't forget to update/test this once you have something to test
    get '*path' => 'static#bot', :constraints => IsItABot.new

    #non-ajax to home path
    get '*path' => 'static#home', :constraints => XHRConstraint.new

    root to: 'static#home'

    resources :users do
        resources :entries
    end
    resources :events do
        resources :races
    end
    resources :races do
        resources :entries
        resources :split_templates
    end
    resources :entries
    resources :events
    resources :split_templates
    resources :contents
    resources :contact
    resources :event_contacts
    resources :interactions
    resources :assoc_contact_events
end
