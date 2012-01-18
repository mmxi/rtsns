class Admin::GroupsController < Admin::ApplicationController
  # GET /admin/groups
  # GET /admin/groups.json
  def index
    @admin_groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_groups }
    end
  end

  # GET /admin/groups/1
  # GET /admin/groups/1.json
  def show
    @admin_group = Admin::Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_group }
    end
  end

  # GET /admin/groups/new
  # GET /admin/groups/new.json
  def new
    @admin_group = Admin::Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_group }
    end
  end

  # GET /admin/groups/1/edit
  def edit
    @admin_group = Admin::Group.find(params[:id])
  end

  # POST /admin/groups
  # POST /admin/groups.json
  def create
    @admin_group = Admin::Group.new(params[:admin_group])

    respond_to do |format|
      if @admin_group.save
        format.html { redirect_to @admin_group, notice: 'Group was successfully created.' }
        format.json { render json: @admin_group, status: :created, location: @admin_group }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/groups/1
  # PUT /admin/groups/1.json
  def update
    @admin_group = Admin::Group.find(params[:id])

    respond_to do |format|
      if @admin_group.update_attributes(params[:admin_group])
        format.html { redirect_to @admin_group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/groups/1
  # DELETE /admin/groups/1.json
  def destroy
    @admin_group = Admin::Group.find(params[:id])
    @admin_group.destroy

    respond_to do |format|
      format.html { redirect_to admin_groups_url }
      format.json { head :ok }
    end
  end
end
