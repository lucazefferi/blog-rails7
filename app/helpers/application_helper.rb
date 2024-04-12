module ApplicationHelper

def current_user
    #this method will return the currently logged in user (if there is one) 
    #and cache the result to avoid unnecessary database queries. 
    #If there is no logged in user, it will return nil. 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

end

def logged_in?
 !!current_user
end

end
