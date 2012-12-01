class UsersController < ApplicationController
  # GET /users/1/compare
  # GET /users/1/compare.json
  def compare
    @@comparable = ["gender", "city", "province"] # identical to model
    @@compareBy = ["time", "money"] # identical to model

    @user = User.find(params[:id])
    @compareSameData = {}
    @compareAllData = {}
    @userData = {}

    # compare against similar users
    @@comparable.each do |attr|
      users = User.where(attr.to_sym => @user.send(attr))

      @compareSameData[attr] = {}
      @@compareBy.each do |metric|
        @compareSameData[attr][metric+"Total"] = 0
      end

      users.each do |user|
        donations = user.donations
 
        donations.each do |donation|
          @@compareBy.each do |metric|
            @compareSameData[attr][metric+"Total"] += donation.send(metric)
          end
        end
        @@compareBy.each do |metric|
          @compareSameData[attr][metric+"Average"] =
              @compareSameData[attr][metric+"Total"] * 1.0 / users.length
        end
      end 
    end





    # compare against all users
    donations = Donation.all

    @@compareBy.each do |metric|
      @compareAllData[metric+"Total"] = 0
    end

    donations.each do |donation|
      @@compareBy.each do |metric|
        @compareAllData[metric+"Total"] += donation.send(metric)
      end
    end

    @@compareBy.each do |metric|
      @compareAllData[metric+"Average"] =
          @compareAllData[metric+"Total"] * 1.0 / User.all.length
    end









    # get a user's own metrics
    donations = Donation.where(:user_id => params[:id])

    @@compareBy.each do |metric|
      @userData[metric] = 0
    end

    donations.each do |donation|
      @@compareBy.each do |metric|
        @userData[metric] += donation.send(metric)
      end
    end



    @id = params[:id]

    # @id, @user, @compareSameData{{}}, @compareAllData{}, @userData{}

    @jsonResponse = [@id, @user, @compareSameData, @compareAllData, @userData]

    respond_to do |format|
      format.html # compare.html.erb
      format.json { render :json => @jsonResponse } # todo
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
