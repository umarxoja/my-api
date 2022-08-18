class Api::V1::CarsController < ApiController
    before_action :set_car, only: %i[ show edit update destroy ]
    # before_action :authenticate_user!
    # GET /cars or /cars.json
    def index
      @cars = Car.all
      render json: @cars
    end
  
    # GET /cars/1 or /cars/1.json
    def show
        render json: @car
    end
  
    # GET /cars/new
    def new
      @car = Car.new
    end
  
    # GET /cars/1/edit
    def edit
    end
  
    # POST /cars or /cars.json
    def create
      @car = Car.new(car_params)
      @car.user = current_user
        if @car.save
          # format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
          render json: @car, status: :created, location: @car
        else
          # format.html { render :new, status: :unprocessable_entity }
          render json: @car.errors, status: :unprocessable_entity
        end
    end
  
    # PATCH/PUT /cars/1 or /cars/1.json
    def update
        if @car.update(car_params)
            render json: @car
          else
            render json: @car.errors, status: :unprocessable_entity
            end
    end
  
    # DELETE /cars/1 or /cars/1.json
    def destroy
      @car.destroy
      if @car.destroy
        head :no_content
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_car
        @car = Car.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def car_params
        params.require(:car).permit(:name, :price, :description, :user_id)
      end
  end
  