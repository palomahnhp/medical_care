class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update, :destroy]

  # GET /professionals
  # GET /professionals.json
  def index
    @search  = Professional.search(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?
    @professionals = @search.result.page(params[:page])
    @search.build_condition
  end

  # GET /professionals/1
  # GET /professionals/1.json
  def show
  end

  # GET /professionals/new
  def new
    if Speciality.all.empty?
      redirect_to professionals_path, alert: 'No hay especialidades, imposible dar de alta un profesional médico. Da de alta la especialidad'
    else
      @professional = Professional.new
    end
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals
  # POST /professionals.json
  def create
    @professional = Professional.new(professional_params)

    respond_to do |format|
      if @professional.save
        format.html { redirect_to @professional, notice: 'Registro creado.' }
        format.json { render :show, status: :created, location: @professional }
      else
        format.html { render :new }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /professionals/1
  # PATCH/PUT /professionals/1.json
  def update
    respond_to do |format|
      if @professional.update(professional_params)
        format.html { redirect_to @professional, notice: 'Registro modificado.' }
        format.json { render :show, status: :ok, location: @professional }
      else
        format.html { render :edit }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professionals/1
  # DELETE /professionals/1.json
  def destroy
    @professional.destroy
    respond_to do |format|
      format.html { redirect_to professionals_url, notice: 'Professional was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professional
      @professional = Professional.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def professional_params
      params.require(:professional).permit(:first_name, :last_name,
                                           :medical_center_id, :speciality_id,
                                           :comments)
    end
end
