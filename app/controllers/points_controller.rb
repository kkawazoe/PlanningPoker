class PointsController < ApplicationController
  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = Point.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new
    @point.group_id = params[:group_id]
    @point.member_id = params[:member_id]

    @group = Group.new()
    @group.id = @point.group_id

    @member = Member.new()
    @member.id = @point.member_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(params[:point])

    respond_to do |format|
      if @point.save
        format.html { redirect_to group_member_point_url(@point.group_id, @point.member_id, @point.id), notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to new_group_member_point_url(@point) }
      format.json { head :no_content }
    end
  end

  def check
    respond_to do |format|
      format.html { redirect_to group_points(@point) }
      format.json { head :no_content }
    end
  end
end
