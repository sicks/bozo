class MapsController < ApplicationController
  before_action :get_map, only: [:show, :edit, :update, :destroy]
  layout "map"

  def new
    @map = Map.new
  end

  def create
    @map = Map.new(map_params)
    system = System.find_by(name: params[:map][:home])
    @map.home_id = system.id unless system.nil?

    if @map.save
      redirect_to @map, notice: "Map Created"
    else
      render :new
    end
  end

  def index

  end

  def show
    gon.nodes = []
    gon.nodes << @map.home_node
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def map_params
    params.require(:map).permit(:title, :corp_id, :home_id)
  end

  def get_map
    corps = current_user.corps.pluck(:id)
    @map = Map.where(corp_id: corps).find( params[:id] )
  end
end
