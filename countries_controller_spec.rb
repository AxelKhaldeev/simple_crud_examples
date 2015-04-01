require 'rails_helper'


RSpec.describe Admin::CountriesController, :type => :controller do

  let(:resource) { create(:country) }

  describe "GET #index" do
    context "without filters" do
      it_behaves_like "simple CRUD index", with_model: Country
    end
  end  


  describe "GET #new" do
    it_behaves_like "simple CRUD new", with_model: Country
  end


  describe "POST #create" do    
    it_behaves_like "simple CRUD create", with_model: Country, redirect_path: "edit_admin_country_path(assigns(:country))" do
      let(:valid_attributes)   { attributes_for(:country) }
      let(:invalid_attributes) { attributes_for(:country, name: nil) }
    end
  end


  describe "GET #edit" do
    it_behaves_like "simple CRUD edit", with_model: Country
  end


  describe "PATCH #update" do
    it_behaves_like "simple CRUD update", with_model: Country, redirect_path: "edit_admin_country_path(assigns(:country))" do
      let(:valid_attributes)   { attributes_for(:country, name: 'Франция', name_en: 'France') }
      let(:invalid_attributes) { attributes_for(:country, name: 'Франция', name_en: nil) }
    end
  end  


  describe "DELETE #destroy" do
    it_behaves_like "simple CRUD destroy", with_model: Country, redirect_path: :admin_countries_path 
  end


end

