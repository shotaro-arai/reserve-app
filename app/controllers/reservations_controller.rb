class ReservationsController < ApplicationController
  before_action :redirect_root, only: :new

  def index
    user_info
    @reservations = Reservation.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def new
    user_info
    @reservation = Reservation.new

    @day = params[:day]
    @time = params[:time]
    @start_time = DateTime.parse(@day + " " + @time + " " + "JST")
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path @reservation.id
    else
      @day = @reservation.day
      @time = @reservation.time
      @start_time = @reservation.start_time
      user_info
      render "new"
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :start_time, :name, :tel)
  end
  
  def redirect_root
    if params[:day]==nil || params[:time]==nil
      redirect_to root_path
    end
  end

  def user_info
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
    end
  end
end
