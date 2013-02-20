# encoding: utf-8

class PointsController < ApplicationController
  # GET /points
  # GET /points.json
  def index
    @points = Point.find(:all, :conditions=>[ "group_id=?", params[:group_id]], :order => 'value desc')
    sum = 0.00
    @points.each {|point| sum += point.value} 

    p sum

    @avg = sum / @points.size

    p @avg

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
    @point.member_id = session[:member].id

    @group = Group.new()
    @group.id = @point.group_id

    member = session[:member]
    points = Point.find_all_by_member_id(member.id )
    points.each {|point| point.delete} 

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
        session[:point] = @point

        format.html { redirect_to group_point_url(@point.group_id, @point.id), notice: '登録しました。 他のメンバが見積り中です。しばらくお待ちください。'}
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
        session[:point] = @point

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
    @point.delete

    respond_to do |format|
      format.html { redirect_to new_group_point_url(@point) }
      format.json { head :no_content }
    end
  end

  def check_results
    @points = Point.find_all_by_group_id(params[:group_id])
    @members = Member.find_all_by_group_id(params[:group_id])

    puts "比較"
    p @points
    p @member
    members = Member.all
    p members

    respond_to do |format|
      if @points.size == @members.size
        format.html { redirect_to group_points_url(params[:group_id])}
      else
        format.html { redirect_to group_point_url(params[:group_id],params[:id]), notice: '登録しました。 他のメンバが見積り中です。しばらくお待ちください。'}
      end
    end
  end
end
