class UsersController < ApplicationController
    
    #prima di eseguire i metodi indicati dentro le [] eseguirà :set_user rendendo @user disponibile dentro i metodi senza cosi dover ripetere
    #"@User = User.find(params[:id])" in tutti i metodi (DRY-> DONT REPEAT YOURSELF)"
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index, :create, :new, :search]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
            session[:user_id] = @user.id #serve per far accedere automaticamente l'utente appena si è registrato
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
              redirect_to user_path(@user.id)
          else
              #flash[:alert] = "Profilo non modificato!"
              render 'edit', status: :unprocessable_entity
          end
      end
  
      def destroy
          #@user = User.find(params[:id])
          if @user.destroy 
             UserMailer.goodbye_email(@user).deliver_now
              flash[:notice] = "Il profilo e tutti gli articoli associati sono stati elimanti!"
              if current_user == @user
              session[:user_id] = nil
              redirect_to root_path
              end
          end
      end

      
    def search
        @users = User.where('username LIKE ?', "%#{params[:query]}%").limit(5)
        render json: @users
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        #se l'utente loggato non è l'utente di cui sta provando ad eliminare l'account e non è nemmeno un admin allora vieta l'azione
        if current_user !=  @user && !current_user.admin?
          flash[:alert] = "Azione non autorizzata, puoi modificare o cancellare solo il tuo profilo."  
          redirect_to user_path(@user)
        end
    end


end
