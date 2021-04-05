class PhasesController < ApplicationController
  before_action :set_phase, only: %i[ show edit update destroy pay_phase choose_worker]

  # GET /phases or /phases.json
  def index
    @phases = Phase.all
  end

  # GET /phases/1 or /phases/1.json
  def show
  end

  # GET /phases/new
  def new
    @phase = Phase.new
  end

  # GET /phases/1/edit
  def edit
  end

  # POST /phases or /phases.json
  def create
    @phase = Phase.new(phase_params)

    respond_to do |format|
      if @phase.save
        format.html { redirect_to @phase, notice: "Phase was successfully created." }
        format.json { render :show, status: :created, location: @phase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  def pay_phase
    if @phase.price > 0

      @amount = (@phase.price * 100).to_i
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )
      charge = Stripe::Charge.create(
        customer:    customer.id,
        amount:      @amount,
        description: 'Phase Payment',
        currency:    'usd'
      )
      @phase.price -= @phase.price
      @phase.project.total_price -= @phase.price
      @phase.save!
      # @enrollment = current_user.buy_course(@phase)
      redirect_to phase_path(@phase), notice: "You are good!"
    else
      # @enrollment = current_user.buy_course(@course)
      redirect_to phase_path(@phase), notice: "You payed this phase!"
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_phase_path(@phase)
  end

  def choose_worker
    phase_type = @phase.phase_type
    case phase_type.to_s
    when "Painting"
      @workers = Worker.where(worker_type: "Moler")
    when "Polishing"
      @workers = Worker.where(worker_type: "Assembler")
    when "Building"
      @workers = Worker.where(worker_type: "Zidar")
    when "Tiles_job"
      @workers = Worker.where(worker_type: "Keramicar")
    else
      @workers = []
    end
  end

  # PATCH/PUT /phases/1 or /phases/1.json
  def update
    if params[:phase][:worker_name].present?
      @worker = Worker.find_by(name: params[:phase][:worker_name])
      @phase.update_column(:worker_name, @worker.name)

      hours_to_complete= (@phase.end_time.to_time - @phase.start_time.to_time)/ 1.hours

      worker_price = @worker.price.to_i * hours_to_complete
      @phase.update_column(:price, worker_price)
    end
    respond_to do |format|
      if @phase.update(phase_params)
        format.html { redirect_to @phase, notice: "Phase was successfully updated." }
        format.json { render :show, status: :ok, location: @phase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phases/1 or /phases/1.json
  def destroy
    @phase.destroy
    respond_to do |format|
      format.html { redirect_to phases_url, notice: "Phase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phase_params
      params.require(:phase).permit(:phase_title, :content, :project_id, :price, :phase_type, :worker_id, :start_time, :end_time, :worker_name)
    end
end
