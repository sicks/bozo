class ConnectionsController < ApplicationController
  layout "map"
  before_action :get_map

  def new
    @connection = @map.connections.build
  end

  def create
    if request.xhr?
      params[:connection] = {}
      params[:connection][:hole_id] = Hole.first.id
      params[:connection][:from_id] = System.find_by(name: params[:from]).id
      params[:connection][:to_id] = System.find_by(name: params[:to]).id
    else
      params[:connection][:from_id] = System.find_by(name: params[:connection][:from]).id
      params[:connection][:to_id] = System.find_by(name: params[:connection][:to]).id
      @map.errors.add(:from, "must be a system") if params[:from_id].nil?
      @map.errors.add(:to, "must be a system") if params[:to_id].nil?
    end
    @conn = @map.connections.build( connection_params )
    respond_to do |format|
      if @conn.save
        format.html { redirect_to @map, notice: 'Connection Added.' }
        format.json { render json: @map, status: :created }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:connection][:from_id] = System.find_by(name: params[:connection][:from]).id
    params[:connection][:to_id] = System.find_by(name: params[:connection][:to]).id
    @map.errors.add(:from, "must be a system") if params[:from_id].nil?
    @map.errors.add(:to, "must be a system") if params[:to_id].nil?

    respond_to do |format|
      if @map.connections.find(params[:id]).update( connection_params )
        format.html { redirect_to @map, notice: 'Connection Updated.' }
        format.json { render json: @map, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @map.connections.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @map, notice: 'Connection Deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def connection_params
    params.require(:connection).permit(:from_id, :to_id, :hole_id, :eol, :stage)
  end

  def get_map
    corps = current_user.corps.pluck(:id)
    @map = Map.where(corp_id: corps).find( params[:map_id] )
  end
end
