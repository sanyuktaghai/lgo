class RegistrationsController < Devise::RegistrationsController
  
  def new 
    super
  end

  def create
    super
  end

  def edit
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @user = current_user
    params[:user][:status] = 'active'
    respond_to do |format|
      if resource.update_without_password(account_update_params)
        flash[:success] = "Profile has been updated"
        format.html { redirect_to dashboard_path(resource) }
      else
        flash.now[:warning] = "Profile has not been updated"
        format.js {render :partial => 'dashboard/registrations/usererrors', :data => resource.to_json  }
      end
    end
  end

  protected
  
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
  def after_sign_up_path_for(resource)
    @user = current_user
    flash[:notice] = nil
    registration_step_path(:basic_details)
  end
  
  private
  
  def account_update_params
    params[:user].permit(:first_name, :last_name, :about_me, :status, :birthday, :gender)
  end
  
end