class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # runs the set_article method found in the private section. This finds the specific article in the database based on the ID in the URL. This is why the show, edit, update, and destroy methods look "empty" or simple—the work of finding @article is already done.

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  # where the actual saving happens.
#It takes the data from the form (article_params).
#If successful: It saves to the database and redirects the user to the new article's page.
#If it fails (e.g., validation error): It "renders" the new view again, showing the user the errors while keeping their typed text in the form.

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # It tries to apply the new changes from the form.
# If successful: Redirects to the updated article.
# If it fails: Rerenders the edit form so the user can fix the mistakes.
# render - Stays on the same URL and just swaps the HTML content.
# render :edit provides the content (the form + the errors).
# status: :unprocessable_entity provides the signal that tells the browser to actually show that content.


  def destroy
    @article.destroy
    redirect_to articles_url, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
  # The reusable "finder" logic

  def article_params
    params.require(:article).permit(:title, :content)
  end
  # security shield that tells Rails: "I only allow the user to change the title and content. Ignore any other data they try to sneak into the request."
end
