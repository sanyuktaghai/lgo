class RegistrationStepsController < ApplicationController
  before_filter :authenticate_user!
  
  include Wicked::Wizard
  
  steps *User.form_steps
  
  def show
    @user = current_user
    render_wizard
  end
  
  def update
    @user = current_user
    params[:user][:status] = 'active' if step == "basic_details"
    @user.update_attributes(user_update_params)
    sign_in(@user, bypass: true)
    render_wizard @user
  end
  
  private
  
  def user_update_params
    params[:user].permit(:first_name, :last_name, :status)
  end
  
  def finish_wizard_path
    dashboard_path(current_user)
  end
end
