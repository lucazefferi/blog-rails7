class SessionsController < ApplicationController
def new   
end

def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        #use flash.now cause we are not use redirect but render
        flash[:notice] = "Bentornato!"
        redirect_to root_path
    else
        flash.now[:alert] = "Verifica i dati inseriti!"
        render 'new' , status: :unprocessable_entity
    end
end

def destroy
    session[:user_id] = nil
    flash[:notice] = "Arrivederci!"
    redirect_to root_path
end


end