class GroupsController < ApplicationController

  def index
    @groups = Group.page(params[:page]).per(20).order("members_count DESC")
    @newest_groups = Group.limit(10).order("created_at DESC")

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @groups }
    end
  end

  def show
    @group = Group.find(params[:id])
    @newest_users = @group.members.limit(8)

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end
  
  def join
    @group = Group.find(params[:id])
    respond_to do |format|
      format.html do
        current_user.become_member_of(@group)
        redirect_to @group
      end
      format.js
    end
  end
  
  def leave
    @group = Group.find(params[:id])
    current_user.leave(@group)
    redirect_to @group
  end
  
end
