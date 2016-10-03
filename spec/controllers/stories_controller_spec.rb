require 'rails_helper'
require 'support/macros' #file manually created

RSpec.describe StoriesController, type: :controller do

  describe "GET #edit" do
    before do
      @foo = FactoryGirl.create(:user)
    end
    
    context "owner is allowed to edit her stories" do
      it "renders the edit template" do
        sign_in @foo
        story = Story.create(raw_title: "first story", raw_body: "body of first story", user: @foo)
        
        get :edit, params: { id: story }
        expect(response).to render_template :edit #since foo created the story, we expect her to edit it
      end
    end
    
    context "non-owner is not allowed to edit other users' stories" do
      it "redirects to the root path" do
        foobar = FactoryGirl.create(:user)
        sign_in foobar
        story = Story.create(raw_title: "first story", raw_body: "body of first story", user: @foo)
        
        get :edit, params: { id: story }
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own stories."
        expect(flash[:warning]).to eq message
      end
    end

#  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
