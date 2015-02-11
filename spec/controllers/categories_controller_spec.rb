require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      get :index
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders the index template" do
      sign_in
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @categories" do
      sign_in
      category1, category2 = Category.create(name: "test1"), Category.create(name: "test2")
      get :index

      expect(assigns(:categories)).to match_array([category1, category2])
    end
  end
  
  describe "GET #show" do  # needed as routing is done through resources
    
    it "responds by rediecting to index view" do
      sign_in
      category = Category.create(name: "test")
      get :show, id: category.id    # needs it for correct routing
      expect(response).to redirect_to(categories_path)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      category = Category.create(name: "test")
      get :show, id: category.id
      expect(response).to redirect_to(new_user_session_path)
    end
    
  end
  
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      get :new
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders the new template" do
      sign_in
      get :new
      expect(response).to render_template("new")
    end
    
  end
  
  describe "POST #create" do
    it "responds successfully with a redirect to categories" do
      sign_in
      post :create, {:category => {name: "test"}}
      expect(response).to redirect_to categories_path
      # expect(response).to be_success
   #    expect(response).to have_http_status(200)
    end
    
    it "responds to failure with rendering the new form" do
      sign_in
      post :create, {:category => {name: nil}}
      expect(response).to render_template("new")
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      post :create
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end
     
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in
      category = Category.create(name: "test")
      get :edit, id: category.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      category = Category.create(name: "test")
      get :edit, id: category.id
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      category = Category.create(name: "test")
      get :edit, id: category.id
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders the edit template" do
      sign_in
      category = Category.create(name: "test")
      get :edit, id: category.id
      expect(response).to render_template("edit")
    end
    
  end
  
  describe "PUT #update" do
    it "responds successfully with different names and a redirect to categories" do
      sign_in
      category = Category.create(name: "test")
      put :update, {id: category.id, :category => {name: "test2"}}
      expect(Category.find(category.id).name).not_to eq(category.name)
      # Category.find(category.id).name.should_not == category.name   # deprectaed
      expect(response).to redirect_to categories_path
    end
    
    it "responds to failure with rendering the edit form" do
      sign_in
      category = Category.create(name: "test")
      put :update, {id: category.id, :category => {name: nil}}
      expect(response).to render_template("edit")
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      category = Category.create(name: "test")
      put :update, {id: category.id, :category => {name: "test2"}}
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      category = Category.create(name: "test")
      put :update, {id: category.id, :category => {name: "test2"}}
      expect(response).to redirect_to(new_user_session_path)
    end
     
  end

  describe "DELETE #destroy" do
    it "responds successfully with the deletion of the category" do
      sign_in
      category = Category.create(name: "test")
      delete :destroy, {id: category.id}
      expect { Category.find(category.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to categories_path
    end
    
    it "responds failure when not signed in" do
      sign_in nil
      category = Category.create(name: "test")
      delete :destroy, {id: category.id}
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end
    
    it "redirect to sign in screen" do
      sign_in nil
      category = Category.create(name: "test")
      delete :destroy, {id: category.id}
      expect(response).to redirect_to(new_user_session_path)
    end
     
  end
  
end
