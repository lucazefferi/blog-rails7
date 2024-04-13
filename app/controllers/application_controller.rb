class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in? #ci permette di rendere disponibili questi metodi anche nelle view

    def current_user
        #this method will return the currently logged in user (if there is one) 
        #and cache the result to avoid unnecessary database queries. 
        #If there is no logged in user, it will return nil. 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    
    end
    
    def logged_in?
     !!current_user
    end

    def require_user
        if !logged_in?
         flash[:alert] = "Azione non autorizzata, accedi o registrati."  
         redirect_to login_path
        end   
    end
end
