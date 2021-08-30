class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User
  def new
    @tweet = Tweet.last(50).map do |f|  
      {
        id: f.id,
        content: f.content,
        user_id: f.user.id,
        like_count: f.total_like,
        retweets_count: f.total_retweet,
        retweetitted_from: f.retweets.first&.user&.id
      }    
    end
    render json: @tweet
  end

  def date_between
    #fecha1 = params[:fecha1].strptime('%y/%m/%d')
    fecha1 = Date.parse(params[:fecha1])    
    fecha2 = Date.parse(params[:fecha2])        
    
    @tweets = Tweet.where(created_at:fecha1..fecha2)
    render  json: @tweets 
  end
  
  def create_tweet
    @tweet = Tweet.create!(api_params)
    render  json: @tweet
  end
  
  private
  def api_params
    params.require(:api).permit(:content, :image_url, :user_id  )
  end
end
