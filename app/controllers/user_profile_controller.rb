class UserProfileController < ApplicationController
    before_action :authenticate_user!
    before_action :subscribes_count
    before_action :posts_count

    add_flash_types :danger
    add_flash_types :success

    def index
        @_types = SubscribeType.all
        @intevals = MailInterval.all
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
    #fucking shit legacy
    # def change_user_name
    #     current_user.name = params[:name]
    #     current_user.save
    #     redirect_to user_profile_index_path, success: "Имя пользователя изменено"
    # end

    # def change_user_lastname
    #     current_user.lastname = params[:lastname]
    #     current_user.save
    #     redirect_to user_profile_index_path, success: "Имя пользователя изменено"
    # end

    # def change_user_email
    #     current_user.email = params[:email]
    #     current_user.save
    #     redirect_to user_profile_index_path, success: "Электронная почта изменена"
    # end
    def upload_file
       current_user.image = params[:image]
       if current_user.save
        redirect_to user_profile_index_path, success: "Фото профиля обновлено"
       else
        redirect_to user_profile_index_path, danger: "Ошибка при обновлении профиля"
       end
    end
    def update
        current_user.update(user_params)
        if current_user.save
            redirect_to user_profile_index_path, success: "Настройки профиля сохранены"
        elsif current_user.errors.any?
            errors = ""
            current_user.errors.full_messages.each do |msg|
                errors << msg
            end
            redirect_to user_profile_index_path, danger: "Ошибка #{errors}"
        else
            redirect_to user_profile_index_path, danger: "Ошибка: Что то пошло не так}"
        end
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

    def unsubscribe_all
        current_user.subscribes.destroy_all
        redirect_back fallback_location: :back, success: 'Вы отписались от всех подписок'
    end

    def subscribes_count
        @subscr_cnt = current_user.subscribes.count
    end

    def posts_count
        @posts_cnt = current_user.news.count
    end

    private
    
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.permit(:name, :lastname, :email, :image, :mail_interval_id, :subscribe_type_id, :about)
    end
end