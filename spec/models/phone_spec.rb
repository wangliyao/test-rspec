require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)
    #factories中定义了association所以需要将contact传入
    home_phone = create(:home_type,
                   contact: contact,
                   phone: '785-555-1234'
    )

    mobile_phone = build(:mobile_type,
                     contact: contact,
                     phone: '785-555-1234'
    )
    # contact = Contact.create(firstname: 'Joe', lastname: 'Tester',
    #                          email: 'joetester@example.com')
    # home_phone = contact.phones.create(phone_type: 'home',
    #                                    phone: '785-555-1234')
    # mobile_phone = contact.phones.build(phone_type: 'mobile',
    #                                     phone: '785-555-1234')
    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    contact = create(:contact)
    create(:home_type,
           contact:contact,
           phone:'785-555-1234')
    other_contact = Contact.new
    other_phone = build(:home_type,contact: other_contact, phone: '785-555-1234')
    expect(other_phone).to be_valid
  end

  it"returns a contact's full name as a string"do
    # contact = Contact.new(firstname: 'John', lastname: 'Doe',
    #                       email: 'johndoe@example.com')
    contact = build(:contact,firstname:'John',lastname:'Doe')
    expect(contact.name).to eq 'John Doe'
  end

  it "allows two contacts to share a phone number" do
    # create(:phone,
    #     phone_type: "home",
    #     phone: "785-234-789"
    # )
    create(:home_type,
           phone: "785-555-1234")
    expect(build(:home_type, phone: "785-555-1234")).to be_valid
  end
end
