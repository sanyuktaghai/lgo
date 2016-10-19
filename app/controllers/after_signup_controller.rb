class AfterSignupController < ApplicationController
  before_filter :authenticate_user!

#  include Wicked::Wizard
#  steps :create_profile
  
  include Wicked::Wizard
  steps(*User.wizard_steps)  


  def show
    @user = current_user
    render_wizard
#    if @user.current_wizard_step.present?
#        jump_to(@user.current_wizard_step)
#    end
  end
#  
  def update
    @user = current_user
    @user.update_attributes(user_update_params)
    sign_in(@user, bypass: true)
    render_wizard @user
  end
  
  private
  
  def user_update_params
    params[:user].permit(:first_name, :last_name)
  end
end
