class AfterSignupController < ApplicationController
#  before_filter :authenticate_user!
  
  include Wicked::Wizard
  
  before_action :set_steps
  before_action :setup_wizard
  
#  steps :create_user, :create_profile
  steps "create_user", "create_profile"
  
  VALIDATIONS = {
    "create_user" => [:email, :password],
    "create_profile" => [:email, :password, :first_name, :last_name],
    }.freeze
  
  class PartialUser < User
    attr_accessor :step
    attr_accessor :session
    
    def self.model_name
      Post.model_name
    end
    
    def save
      if self.steps == VALIDATIONS.keys.last
        rv = super
        session.delete(:user_wizard) if rv
        self.session = nil
        return rv
      end
      
      self.session = nil
      
      self.valid?
      (self.errors.messages.keys - VALIDATIONS[self.steps]).each do |k|
        self.errors.messages.delete(k)
      end
      
      self.errors.empty?
    end
  end
  
  def show
    if session[:user_wizard].try(:[], :post).present?
      @user = session[:user_wizard][:post]
    end
#    @user = current_user
    render_wizard
  end
  
  def update
#    @user = current_user
    @user = session[:user_wizard][:post]
    @user.attributes = params[:user]
    
    @user.step = step
    @user.session = session
#    @user.update_attributes(user_update_params)
    sign_in(@user, bypass: true)
    render_wizard @user
  end
  
  private
  
  def user_update_params
    params[:user].permit(:first_name, :last_name)
  end
  
  private
  def set_steps
    if params[:flow] == "create_user"
      self.steps = [:create_user, :create_profile]
    end
  end
end
