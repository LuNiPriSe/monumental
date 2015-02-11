require 'rails_helper'

RSpec.describe CollectionsController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      curret_user = User.create(email: "test@test.de")
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
#     it "responds failure when not signed in" do
#       sign_in nil
#       get :index
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       get :index
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#     it "renders the index template" do
#       sign_in
#       get :index
#       expect(response).to render_template("index")
#     end
#
#     it "loads all of the posts into @collections" do
#       sign_in
#       collection1, collection2 = Collection.create(name: "test1"), Collection.create(name: "test2")
#       get :index
#
#       expect(assigns(:collections)).to match_array([collection1, collection2])
#     end
#   end
#
#   describe "GET #show" do
#     it "responds successfully with an HTTP 200 status code" do
#       sign_in
#       collection = Collection.create(name: "test")
#       get :show, id: collection.id
#       expect(response).to be_success
#       expect(response).to have_http_status(200)
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       get :show, id: collection.id
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       get :show, id: collection.id
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#     it "renders the new template" do
#       sign_in
#       collection = Collection.create(name: "test")
#       get :show, id: collection.id
#       expect(response).to render_template("new")
#     end
#
#   end
#
#   describe "GET #new" do
#     it "responds successfully with an HTTP 200 status code" do
#       sign_in
#       get :new
#       expect(response).to be_success
#       expect(response).to have_http_status(200)
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       get :new
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       get :new
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#     it "renders the new template" do
#       sign_in
#       get :new
#       expect(response).to render_template("new")
#     end
#
#   end
#
#   describe "POST #create" do
#     it "responds successfully with a redirect to collections" do
#       sign_in
#       post :create, {:collection => {name: "test"}}
#       expect(response).to redirect_to collections_path
#       # expect(response).to be_success
#    #    expect(response).to have_http_status(200)
#     end
#
#     it "responds to failure with rendering the new form" do
#       sign_in
#       post :create, {:collection => {name: nil}}
#       expect(response).to render_template("new")
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       post :create
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       post :create
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#   end
#
#   describe "GET #edit" do
#     it "responds successfully with an HTTP 200 status code" do
#       sign_in
#       collection = Collection.create(name: "test")
#       get :edit, id: collection.id
#       expect(response).to be_success
#       expect(response).to have_http_status(200)
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       get :edit, id: collection.id
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       get :edit, id: collection.id
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#     it "renders the edit template" do
#       sign_in
#       collection = Collection.create(name: "test")
#       get :edit, id: collection.id
#       expect(response).to render_template("edit")
#     end
#
#   end
#
#   describe "PUT #update" do
#     it "responds successfully with different names and a redirect to collections" do
#       sign_in
#       collection = Collection.create(name: "test")
#       put :update, {id: collection.id, :collection => {name: "test2"}}
#       expect(Collection.find(collection.id).name).not_to eq(collection.name)
#       # Collection.find(collection.id).name.should_not == collection.name   # deprectaed
#       expect(response).to redirect_to collections_path
#     end
#
#     it "responds to failure with rendering the edit form" do
#       sign_in
#       collection = Collection.create(name: "test")
#       put :update, {id: collection.id, :collection => {name: nil}}
#       expect(response).to render_template("edit")
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       put :update, {id: collection.id, :collection => {name: "test2"}}
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       put :update, {id: collection.id, :collection => {name: "test2"}}
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
#   end
#
#   describe "DELETE #destroy" do
#     it "responds successfully with the deletion of the collection" do
#       sign_in
#       collection = Collection.create(name: "test")
#       delete :destroy, {id: collection.id}
#       expect { Collection.find(collection.id) }.to raise_error(ActiveRecord::RecordNotFound)
#       expect(response).to redirect_to collections_path
#     end
#
#     it "responds failure when not signed in" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       delete :destroy, {id: collection.id}
#       expect(response).not_to be_success
#       expect(response).to have_http_status(302)
#     end
#
#     it "redirect to sign in screen" do
#       sign_in nil
#       collection = Collection.create(name: "test")
#       delete :destroy, {id: collection.id}
#       expect(response).to redirect_to(new_user_session_path)
#     end
#
  end

  
  it "should show users collections"
  
  it "should show a form for a new collection"
  
  it "should create a new collection"
    
  it "shouldn't create a collection without name"
  
  it "shouldn't create a collection without owner"
  
  it "should render the erronious form and display error messages"
  
  it "should update a collection"
    
  it "shouldn't update a collection without name"
  
  it "shouldn't update a collection without owner"
  
  it "should show new monument form with correct collection"
  
end
