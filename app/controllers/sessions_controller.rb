class SessionsController < Devise::SessionsController

  def create
    respond_to do |format|
      format.html { super }
      format.json {
        resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
        render :json => { :success => true, :user => resource}
      }
    end
  end
  
end