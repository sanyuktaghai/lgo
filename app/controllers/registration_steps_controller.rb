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
    respond_to do |format|
      if @user.update_attributes(user_update_params)
        sign_in(@user, bypass: true)
        format.html { render_wizard @user }
      else
        flash.now[:warning] = "User has not been created"
        format.js {render :partial => '/registration_steps/usererrors', :data => @user.to_json  }
      end
    end
  end
  
  private
  
  def user_update_params
    params[:user].permit(:first_name, :last_name, :status, :gender, :age_range)
  end
  
  def finish_wizard_path
    flash[:primary] = "You have signed up successfully."
    dashboard_path(current_user)
  end
end
