class DonationsController < ApplicationController
  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all unless (params[:user_id] or params[:organization_id])
    @donations = Donation.where(:user_id => params[:user_id]) if params[:user_id]
    @donations = Donation.where(:organization_id => params[:organization_id]) if params[:organization_id]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @donations }
    end
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @donation }
    end
  end

  # GET /donations/new
  # GET /donations/new.json
  def new
    @donation = Donation.new
    @donation.user_id = params[:user_id] if params[:user_id]
    @donation.organization_id = params[:organization_id] if params[:organization_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @donation }
    end
  end

  # GET /donations/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(params[:donation])

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, :notice => 'Donation was successfully created.' }
        format.json { render :json => @donation, :status => :created, :location => @donation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /donations/1
  # PUT /donations/1.json
  def update
    @donation = Donation.find(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        format.html { redirect_to @donation, :notice => 'Donation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @donation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to donations_url }
      format.json { head :no_content }
    end
  end
end
