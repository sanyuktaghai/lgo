class AfterSignupController < ApplicationController
#  before_filter :authenticate_user!
#  
#  include Wicked::Wizard
#  
#  steps :create_profile
#  
#  def show
#    @user = current_user
#    render_wizard
#  end
#  
#  def update
#    @user = current_user
#    @user.update_attributes(user_update_params)
#    sign_in(@user, bypass: true)
#    render_wizard @user
#  end
#  
#  private
#  
#  def user_update_params
#    params[:user].permit(:first_name, :last_name)
#  end
end
