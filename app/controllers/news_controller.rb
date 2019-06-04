# frozen_string_literal: true

class NewsController < ApplicationController
  include NewsHelper
  before_action :authenticate_user!
  before_action :set_news, only: [:show, :edit, :update, :destroy, :add_comment, :like, :favorite_add]
  before_action :check_user_only, only: [:index]

  add_flash_types :danger
  add_flash_types :success

  # GET /news
  # GET /news.json
  def index
    if @only_my
      @news = News.joins("LEFT JOIN users
        ON users.id = news.user_id
        LEFT JOIN subscribes
        ON subscribes.user_id = #{current_user.id}
        ").where('subscribes.s_user_id = news.user_id').paginate(page: params[:page]).order(created_at: :desc)
    else
      @news = News.all.paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show; end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit; end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    @news.DateTime = Time.now.asctime
    @news.user_id = current_user.id
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, success: 'Запись успешно обновлена.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, success: 'Запись успешно обновлена.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, success: 'Запись успешно удалена.' }
      format.json { head :no_content }
    end
  end

  def add_comment
    @comment = @news.comments.create!([{ user_id: current_user.id, text: params[:text] }])
    redirect_to news_path(@news), success: 'Комментарий добавлен.'
  end

  def delete_comment
    @comment = Comment.find(params[:comment_id])
    if @comment.destroy
      redirect_back fallback_location: :back, success: 'Комментарий удален.'
    end
  end

  def like
    respond_to do |format|
      user_like = check_like(@news)
      if user_like
        if user_like.destroy
          @img = ActionController::Base.helpers.asset_path('svg/heart-regular.svg')
          format.json { render json: { likes: @news.likes.count, img: @img }, status: :ok }
        else
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      else
        @like = Like.new(user_id: current_user.id, news_id: @news.id)
        if @like.save
          @img = ActionController::Base.helpers.asset_path('svg/heart-solid.svg')
          format.json { render json: { likes: @news.likes.count, img: @img }, status: :ok }
        else
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def favs
    @news = News.joins("LEFT JOIN favorites ON favorites.news_id = news.id").where("news.id = favorites.news_id and favorites.user_id = #{current_user.id}")
    respond_to do |format|
      format.html {render :'news/favorites'}
    end
  end

  def favorite_add
    respond_to do |format|
      user_favorite = check_favorite(@news)
      if user_favorite
        if user_favorite.destroy
          @img = ActionController::Base.helpers.asset_path('svg/star-regular.svg')
          format.json {render json: {img: @img, result: "deleted"}, status: :ok}
        else
          format.json {render json: user_favorite.errors, status: :unprocessable_entity}
        end
      else
        @fav = Favorite.new(user_id: current_user.id, news_id: @news.id)
        if @fav.save
          @img = ActionController::Base.helpers.asset_path('svg/star-solid.svg')
          format.json {render json: {img: @img, result: "added"}, status: :ok}
        else
          format.json {render json: @fav.errors, status: :unprocessable_entity}
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def news_params
    params.require(:news).permit(:title, :text, :image, :only_my)
  end

  def check_user_only
    @only_my = params[:only_my]
  end
end
