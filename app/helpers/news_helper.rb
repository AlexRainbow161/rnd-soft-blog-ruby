module NewsHelper
  def check_like(news)
    @user_like = Like.left_joins(:user, :news).where(users: {id: current_user.id}, news: {id: news.id}).take
  end

  def check_favorite(news)
    @user_favorite = Favorite.left_joins(:user, :news).where(users: {id: current_user.id}, news: {id: news.id}).take
  end
end
