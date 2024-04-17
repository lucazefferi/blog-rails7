class CategoriesController < ApplicationController
    #prima di eseguire i metodi indicati dentro le [] eseguirà :set_article rendendo @article disponibile dentro i metodi senza cosi dover ripetere
    #"@article = Article.find(params[:id])" in tutti i metodi (DRY-> DONT REPEAT YOURSELF)"
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_admin, only: [:edit, :update, :destroy]

    def show
        #binding.breakp -> blocca il codice e fa partire il debug, scrivo params in console per vedere i parametri
        #@article = Article.find(params[:id])
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    #mostra il form per creare un nuovo articolo
    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Categoria salvata!"
            redirect_to category_path(@category)
        else
            #flash[:alert] = "Articolo non salvato!"
            render 'new', status: :unprocessable_entity
        
        end
    end


    def edit
      #@article = Article.find(params[:id])
    end

    def update
        #@article = Article.find(params[:id])
        puts params
        if @category.update(category_params)
            flash[:notice] = "Categoria modificata!"
            redirect_to category_path(@category)
        else
            #flash[:alert] = "Articolo non modificato!"
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        if @category.destroy 
            flash[:notice] = "Categoria rimossa!"
            redirect_to category_path
        end
    end

    private #sotto sono metodi privati

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !current_user.admin?
            flash[:alert] = "Azione non autorizzata, non puoi modificare le categorie."  
            redirect_to root_path
          end
    end

end
