module SimpleCrudExamples

  shared_examples "simple CRUD index" do |opt|
    
    let(:pluralized_assigns_model_name) { opt[:with_model].to_s.underscore.pluralize.to_sym }
    # call resource to force of creating in database
    before(:each) { resource }

    it "fill an array of all #{opt[:with_model].to_s.pluralize}" do
      get :index
      expect(assigns(pluralized_assigns_model_name)).to match_array([resource])
    end
    
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index 
    end

  end



  shared_examples "simple CRUD new" do |opt|

    it "assigns a new #{opt[:with_model]} to @#{opt[:with_model].to_s.underscore}" do
      get :new
      expect(assigns(opt[:with_model].to_s.underscore.to_sym)).to be_a_new(opt[:with_model])
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end

  end



  shared_examples "simple CRUD create" do |opt|

    let(:model_symbol) { opt[:with_model].to_s.underscore.to_sym }

    context "with valid attributes" do
      it "saves the new #{opt[:with_model]} in database" do
        expect {
          post :create, model_symbol => valid_attributes 
        }.to change(opt[:with_model], :count).by(1)
      end
      it "redirects to #{opt[:redirect_path]}" do
        post :create, model_symbol => valid_attributes
        expect(response).to redirect_to eval(opt[:redirect_path].to_s)
      end
    end

    context "with invalid attributes" do
      it "does not save the new #{opt[:with_model]} in database" do
        expect {
          post :create, model_symbol => invalid_attributes 
        }.to_not change(opt[:with_model], :count)
      end
      it "re-renders the :new template" do
        post :create, model_symbol => invalid_attributes 
        expect(response).to render_template :new
      end
    end    

  end



  shared_examples "simple CRUD edit" do |opt|

    it "assigns the requested #{opt[:with_model]} to @#{opt[:with_model].to_s.underscore}" do
      get :edit, id: resource 
      expect(assigns(opt[:with_model].to_s.underscore.to_sym)).to eq resource 
    end

    it "renders the :edit template" do
      get :edit, id: resource
      expect(response).to render_template :edit
    end

  end



  shared_examples "simple CRUD update" do |opt|
    
    let(:model_symbol) { opt[:with_model].to_s.underscore.to_sym }

    context "with valid attributes" do
      it "updates the #{opt[:with_model]} in database" do
        patch :update, id: resource, model_symbol => valid_attributes 
        resource.reload
        valid_attributes.each do |attr, value|
          expect(eval("resource.#{attr}")).to eq value 
        end
      end
      it "redirects to #{opt[:redirect_path]}" do
        patch :update, id: resource, model_symbol => resource.attributes 
        expect(response).to redirect_to eval(opt[:redirect_path].to_s)
      end
    end

    context "with invalid attributes" do
      it "does not update the #{opt[:with_model]} in database" do
        patch :update, id: resource, model_symbol => invalid_attributes 
        resource.reload
        invalid_attributes.each do |attr, value|
          expect(eval("resource.#{attr}")).to_not eq value 
        end
      end
      it "re-renders the :edit template" do
        patch :update, id: resource, model_symbol => invalid_attributes
        expect(response).to render_template :edit
      end
    end
    
  end



  shared_examples "simple CRUD destroy" do |opt|

    it "deletes the #{opt[:with_model]} from database" do
      expect {
        delete :destroy, id: resource
      }.to change(resource.class, :count).by(-1)
    end

    it "redirects to #{opt[:with_model].to_s.pluralize}#index" do
      delete :destroy, id: resource
      expect(response).to redirect_to eval(opt[:redirect_path].to_s)
    end

  end



end

