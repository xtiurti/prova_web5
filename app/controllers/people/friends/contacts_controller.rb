class People::Friends::ContactsController < ApplicationController
  before_action :set_person
  before_action :set_friend
  before_action :set_contact, only: [:edit, :update, :show, :destroy]
  
  def index
    @contacts = @friend.contacts.all

    respond_to do |format|
      format.html
      format.json {render json: @contacts}
    end
  end

  def show
    @contact = @friend.contacts.find(params[:id])
  end

  def new
    @contact = @friend.contacts.new
  end

  def create
    @contact = @friend.contacts.new(contact_params)
  
    respond_to do |format|
      if @contact.save
        format.html { redirect_to person_friend_contacts_path, notice: 'Contacts was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @friend.contacts.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to person_friend_contacts_path, notice: 'contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
     respond_to do |format|
      if @contact.destroy
        format.html { redirect_to person_friend_contacts_path, notice: 'Contact was dropped.' }
        format.json { render :show, status: :ok, location: @contact }
        format.js
      end
     end
  end

private  
  def set_friend
      @friend = Friend.find(params[:friend_id])
  end
  
  def set_person
      @person = Person.find(params[:person_id])  
  end

  def set_contact
      @contact = @friend.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:tipo, :valor)
  end

end
