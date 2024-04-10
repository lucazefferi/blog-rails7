class UsersController < ApplicationController
    
    #prima di eseguire i metodi indicati dentro le [] eseguirà :set_user rendendo @user disponibile dentro i metodi senza cosi dover ripetere
    #"@User = User.find(params[:id])" in tutti i metodi (DRY-> DONT REPEAT YOURSELF)"
    before_action :set_user, only: [:edit, :update, :destroy]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:notice] = "Benvenuto a bordo!"
            redirect_to root_path
        else
            #flash[:alert] = "Articolo non salvato!"
            render 'new', status: :unprocessable_entity
        
        end
    end


    
    def edit
        #@user = User.find(params[:id])
    end
  
      def update
          #@user = User.find(params[:id])
          puts params
          if @user.update(user_params)
              flash[:notice] = "Profilo modificato!"
              redirect_to articles_path
          else
              #flash[:alert] = "Profilo non modificato!"
              render 'edit', status: :unprocessable_entity
          end
      end
  
      def destroy
          #@user = User.find(params[:id])
          if @user.destroy 
              flash[:notice] = "Profilo eliminato!"
              redirect_to root_path
          end
      end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
