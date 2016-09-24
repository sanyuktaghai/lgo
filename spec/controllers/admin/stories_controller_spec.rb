require 'rails_helper'
require 'support/macros'

RSpec.describe Admin::StoriesController, type: :controller do
  describe "GET #index" do
    before do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
    end
    
    context "admin is allowed to access admin path" do
      it "renders the admin root path" do
        sign_in @admin
        
        get :index
        expect(response).to render_template :index
      end
    end
    
    context "non-admin is not allowed to access /admin" do
      it "redirects to the root path" do
        sign_in @user
        
        get :index
        expect(response).to redirect_to(root_path)
        message = "Error."
        expect(flash[:alert]).to eq message
      end
    end
  end
end
