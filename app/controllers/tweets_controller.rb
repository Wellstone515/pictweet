class TweetsController < ApplicationController

    # before_action :move_to_index, except: :index

    def index
      @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    end

    def new
      return
    end

    def create
      Tweet.create(image: tweets_params[:image], text: tweets_params[:text], user_id: current_user.id)
    end

    def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy if @tweet.user_id == current_user.id
    end

    def edit
      @tweet = Tweet.find(params[:id])
    end

    def update
      @tweet = Tweet.find(params[:id])
      @tweet.update(tweet_params) if @tweet.user_id == current_user.id
    end

    def show
      @tweet = Tweet.find(params[:id])
      @comments = @tweet.comments.includes(:user)
    end

    private
    def tweets_params
      params.permit(:image, :text)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end
end