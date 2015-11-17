class ConnectionsController < ApplicationController
  layout "map"
  before_action :get_map

  def new
    @connection = @map.connections.build
  end

  def create
    params[:connection][:from_id] = System.find_by(name: params[:connection][:from]).id
    params[:connection][:to_id] = System.find_by(name: params[:connection][:to]).id
    @map.errors.add(:from, "must be a system") if params[:from_id].nil?
    @map.errors.add(:to, "must be a system") if params[:to_id].nil?

    @map.connections.build( connection_params )
    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'Connection Added.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def connection_params
    params.require(:connection).permit(:from_id, :to_id, :hole_id, :eol, :stage)
  end

  def get_map
    corps = current_user.corps.pluck(:id)
    @map = Map.where(corp_id: corps).find( params[:id] )
  end
end
