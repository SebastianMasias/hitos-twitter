class TweetsController < ApplicationController   

  def index
    @q = Tweet.ransack(params[:q])
    @tweets = Tweet.order(:created_at).reverse_order.page params[:page]
    @tweet = Tweet.new

      
     if params.has_key? :search
       @tweets = @tweets.where("content LIKE '%#{params[:search]}%'")
     else
       @tweets 
     end
  end

  def search_tweet
    @q = Tweet.ransack(params[:q])          
    @tweet_search = @q.result(distinct: true)    
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save!
      flash[:notice] = "Fake Tweet creado con exito."      
    else
      flash[:notice] = "Fake Tweet  no pudo ser creado."      
    end    
    redirect_to root_path    
  end

  def show    
    @tweet = Tweet.find(params[:id])
  end

  def edit
  end

 

  def update
  end

  def destroy
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :image_url)
  end
end
