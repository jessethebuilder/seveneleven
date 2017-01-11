module UserHelper
  def authenticate_admin!
    unless user_is_admin?
      redirect_to root_path, alert: "You must be an admin to access that page"
    end
  end

  def user_is_admin?
    user_signed_in? && current_user.admin?
  end

  def current_store_list
    if user_signed_in?
      current_user.current_store_list || build_current_store_list
    end
  end

  def build_current_store_list
    current_user.current_store_list = StoreList.create
    current_user.current_store_list
  end
end
