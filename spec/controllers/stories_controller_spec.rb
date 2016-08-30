require 'rails_helper'
require 'support/macros' #file manually created

RSpec.describe StoriesController, type: :controller do

  describe "GET #edit" do
    before do
      @foo = User.create(email: "foo@bar.com", password: "password")
    end
    
    context "owner is allowed to edit her articles" do
      it "renders the edit template" do
        sign_in @foo
        story = Story.create(title: "first story", body: "body of first story", user: @foo)
        
        get :edit, id: story
        expect(response).to render_template :edit #since foo created the story, we expect her to edit it
      end
    end
    
    context "non-owner is not allowed to edit other users' articles" do
      it "redirects to the root path" do
        foobar = User.create(email: "foobar@bar.com", password: "password")
        sign_in foobar
        story = Story.create(title: "first story", body: "body of first story", user: @foo)
        
        get :edit, id: story
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own stories."
        expect(flash[:danger]).to eq message
      end
    end

#  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
