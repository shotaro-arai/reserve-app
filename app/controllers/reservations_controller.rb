class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

  def new
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
      @name = @reservation.name
      @tel = @reservation.tel
      render "new"
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time, :start_time, :name, :tel)
  end
  
end
