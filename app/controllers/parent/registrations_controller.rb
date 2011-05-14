class Parent::RegistrationsController < Devise::RegistrationsController
  layout 'parent'
  include Parent::BaseHelper

  def update
    # Devise use update_with_password instead of update_attributes.
    # This is the only change we make.
    params[resource_name].delete(:password) if params[resource_name][:password].blank?
    params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank?
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  def after_sign_up_path_for(resource)
    parent_root_path
  end

  def after_update_path_for(resource)
    parent_root_path
  end

  def after_sign_up_path_for(resource)
    new_parent_session_path
  end
end
