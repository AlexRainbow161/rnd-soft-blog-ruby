class UserProfileController < ApplicationController
    before_action :authenticate_user!

    add_flash_types :danger
    add_flash_types :success

    def Index
    end

    def show
        @user = set_user
    end

    def change_subscr_period
        @subscr = Subscribe.find(params[:id])
        @subscr.schedule_interval_days = params[:period]
        if @subscr.save
            redirect_to user_profile_index_path, success: "Период рассылки изменен"
        else
            redirect_to user_profile_index_path, danger: "Ошибка при изменение периода рассылки"
        end
        
    end
    def change_user_name
        current_user.name = params[:name]
        current_user.save
        redirect_to user_profile_index_path, success: "Имя пользователя изменено"
    end
    def change_user_email
        current_user.email = params[:email]
        current_user.save
        redirect_to user_profile_index_path, success: "Электронная почта изменена"
    end
    def upload_file
        current_user.image = params[:picture]
        current_user.save
        redirect_to user_profile_index_path, success: "Фото профиля обновлено"
    end

    def subscribe
        @user = set_user;
        @subscr = Subscribe.new(user_id: current_user.id, s_user_id: @user.id, schedule_interval_days: 1, active: true)
        if @subscr.save
            redirect_back fallback_location: :back, success: "Вы подписались на пользователя #{@user.name}"
        else
            redirect_back fallback_location: :back, danger: "Что то пошло не так #{@subscr.errors}"
        end
      end
      def unsubscribe
        @subscr = Subscribe.where(user_id: current_user.id, id: params[:id]).take
        @subscr.destroy
        redirect_back fallback_location: :back, success: 'Вы отписались.'
      end

    private
    
    def set_user
        @user = User.find(params[:id])
    end

end