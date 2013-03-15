class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

  def index
    @services = current_user.services.all
  end

  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy
    redirect_to services_path
  end

  def create
    params[:service] ? service_route = params[:service] : service_route = 'no service (invalid callback)'
    auth = request.env['omniauth.auth']
    if auth and params[:service] and auth['uid'] and auth['provider']
      serv = Service.find_by_provider_and_uid(auth['provider'], auth['uid'])
      if !user_signed_in?
        if serv
          flash[:notice] = 'Signed in successfully via ' + serv.provider + '.'
          sign_in_and_redirect(:user, serv.user)
        else
          user = User.create_with_omni(auth)
          if user.persisted?
            user.add_service_profile_rating(auth)
            flash[:notice] = 'Signed in successfully via ' + auth['provider'] + '. Please set your email in profile'
            sign_in_and_redirect user
          else
            flash[:error] = 'Authentication error. Please try again.'
            redirect_to new_user_session_path
          end
        end
      else
        if !serv
          current_user.services.create(:provider => provider, :uid => uid, :uname => name, :uemail => email)
          flash[:notice] = 'Sign in via ' + auth['provider'] + ' has been added to your account.'
          redirect_to services_path
        else
          flash[:notice] = auth['provider'] + ' is already linked to your account.'
          redirect_to services_path
        end
      end
    end
  end

end
