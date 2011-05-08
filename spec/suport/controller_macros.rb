module ControllerMacros
  def login_parent
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:parent]
      sign_in Factory.create(:parent)
    end
  end
end
