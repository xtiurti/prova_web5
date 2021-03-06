class People::PhonesController < ApplicationController
  before_action :set_person
  before_action :set_phone, only: [:edit, :update, :destroy, :update, :show]

  def index
    @phones = @person.phones.all
  end

  def show
    
  end

  def new
    @phone = @person.phones.new
  end

  def create
    @phone = @person.phones.new(phone_params)

    respond_to do |format|
      if @phone.save
        format.html { redirect_to person_phones_path, notice: 'Phone was successfully created.' }
        format.json { render :show, status: :created, location: @phone }
        if (@phone.default)
          @person.phones.where.not(:id => @phone).update_all(:default => false)
        end
      else
        format.html { render :new }
        format.json { render json: @person.phones.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to person_phones_path, notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone }
        if (@phone.default)
          @person.phones.where.not(:id => @phone).update_all(:default => false)
        end
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     respond_to do |format|
      if @phone.destroy
        format.html { redirect_to person_phones_path, notice: 'Phone was dropped.' }
        format.json { render :show, status: :ok, location: @phone }
      end
     end
  end

  private
  def set_phone
    @phone = @person.phones.find(params[:id])
  end
  
  def set_person
    @person = Person.find(params[:person_id])
  end

  def phone_params
    params.require(:phone).permit(:number, :default)
  end

end
