class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  # Issue 6・7 でも使う（未ログインならログイン画面へ）
  def require_login
    return if logged_in?
    redirect_to login_path, alert: "ログインしてください"
  end

  # 管理者だけ通す（Issue 8・9 でも使う）
  def require_admin
    return require_login unless logged_in?
    redirect_to root_path, alert: "管理者のみアクセスできます" unless current_user.admin?
  end
end
