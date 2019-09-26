class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :destroy, :show]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def destroy
        @article.destroy
        flash[:notice] = "Article was destroyed"
        redirect_to articles_path
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def create
        # render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            # do something
            flash[:notice] = "Article was successfully created"
            redirect_to article_path(@article)
        else 
            render 'new'
        end
        #@article.save
        #redirect_to_article path(@article)
    end

    def show
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

end