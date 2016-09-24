require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
      @foo = User.create(email: "foo@bar.com", password: "password")
    end
    
    context "signed in user" do
      it "can create a comment" do
        login_user @foo
        story = Story.create(
          raw_title: "First Story", 
          raw_body: "Body of first story", 
          user: @foo)
        post :create, params: { 
          comment: {body: "Great story!"},#post to create action
          story_id: story.id }
        expect(flash[:success]).to eq("Comment has been added")
      end
    end
    context "non-signed-in user" do
      it "is redirected to the sign in page" do
        login_user nil #we don't have a logged-in user
        story = Story.create(
        raw_title: "First Story", 
        raw_body: "Body of first story", 
        user: @foo)
        post :create, params: {comment: {body: "Great story!"}, story_id: story.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
