class TripsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :owns_trip, only: [:edit, :update, :destroy]
  # GET /trips
  # GET /trips.json
  def index
    @search = Trip.search(params[:q])
    @trips = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Hello World"
        send_data pdf.render, filename: "trip_#{@trip.id}",
                              type: "application/pdf",
                              disposition: 'inline'
      end
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
      format.js # new.js.erb
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])
    @trip.user = current_user

    respond_to do |format|
      if @trip.save
        @trips = Trip.all
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])
    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        @trips = Trip.all
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
      format.js
    end
  end

end
