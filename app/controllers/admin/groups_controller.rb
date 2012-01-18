class Admin::GroupsController < Admin::ApplicationController
  def index
    @groups = Group.page(params[:page]).per(8).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @groups }
    end
  end

  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = current_user.groups.new(params[:group])
    @group.verified = params[:group][:verified]
    @group.allowadduser = params[:group][:allowadduser]

    respond_to do |format|
      if @group.save
        format.html { redirect_to admin_groups_url, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @admin_group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.accessible = :all if current_user.admin?

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to admin_groups_url, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to admin_groups_url }
      format.json { head :ok }
    end
  end
end
