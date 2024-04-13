class ArticlesController < ApplicationController
    #prima di eseguire i metodi indicati dentro le [] eseguirà :set_article rendendo @article disponibile dentro i metodi senza cosi dover ripetere
    #"@article = Article.find(params[:id])" in tutti i metodi (DRY-> DONT REPEAT YOURSELF)"
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        #binding.breakp -> blocca il codice e fa partire il debug, scrivo params in console per vedere i parametri
        #@article = Article.find(params[:id])
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    #mostra il form per creare un nuovo articolo
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Articolo salvato!"
            redirect_to article_path(@article)
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
        if @article.update(article_params)
            flash[:notice] = "Articolo modificato!"
            redirect_to article_path(@article)
        else
            #flash[:alert] = "Articolo non modificato!"
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        #@article = Article.find(params[:id])
        if @article.destroy 
            flash[:notice] = "Articolo rimosso!"
            redirect_to articles_path
        end
    end

    private #sotto sono metodi privati

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user !=  @article.user && !current_user.admin?
          flash[:alert] = "Azione non autorizzata, puoi modificare o cancellare solo i tuoi articoli."  
          redirect_to article_path(@article)
        end
    end

end
