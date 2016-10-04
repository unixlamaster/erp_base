class ContractsController < ApplicationController
  include ApplicationHelper

  def new_wo
    @workobjects = Workobject.all
    @contract = Contract.find(params[:c_id])
    @c_wo_job = ContractWoJobhands.new
    @c_wo_job.contract_id = params[:c_id]
    @url = contracts_add_wo_path
  end
  

  def add_wo
    @c_wo_job = ContractWoJobhands.new(params[:contract_wo_jobhands])

    respond_to do |format|
      if @c_wo_job.save
        format.html { redirect_to contracts_path, notice: 'Object was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update_wo
    @c_wo_job = ContractWoJobhands.find(params[:contract_wo_jobhands][:id])

    respond_to do |format|
      if @c_wo_job.update_attributes(params[:contract_wo_jobhands])
        format.html { redirect_to contracts_path, notice: 'Object was successfully update.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit_wo
    @c_wo_job = ContractWoJobhands.find(params[:id])
    @contract = @c_wo_job.contract
    @workobjects = Workobject.all
    @workobject = @c_wo_job.workobject
    @url = contracts_update_wo_path
  end

  def del_wo
    @c_wo_job = ContractWoJobhands.find(params[:c_id])
    @c_wo_job.destroy

    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.search(params[:search]).order(sort_column + " " + sort_direction + ",id asc").paginate(:per_page => COUNT_STRING_ON_PAGE-10, :page => params[:page])
    @wo_all = Workobject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.json
  def new
    @contract = Contract.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(params[:contract])

    respond_to do |format|
      if @contract.save
        format.html { redirect_to contracts_path, notice: 'Contract was successfully created.' }
        format.json { render json: @contract, status: :created, location: @contract }
      else
        format.html { render action: "new" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.json
  def update
    @contract = Contract.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to contracts_path, notice: 'Contract was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to contracts_url }
      format.json { head :no_content }
    end
  end

end
