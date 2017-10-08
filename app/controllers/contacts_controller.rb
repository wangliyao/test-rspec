class ContactsController < ApplicationController

  before_action :set_contact, only: [:show, :edit, :update, :destroy]


  def index
    if params[:letter]
      @contacts = Contact.by_letter(params[:letter])
    else
      @contacts = Contact.order("lastname, firstname")
    end
  end

  def show
  end

  def new
    @contact = Contact.new
    %w(home office mobile).each do |phone|
      @contact.phones.build(phone_type: phone)
    end
  end


  def edit
  end


  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end


  def contact_params
    params.require(:contact).permit(:firstname, :lastname, :email,
                                    :phones_attributes => [:id, :phone, :phone_type])
  end
end
