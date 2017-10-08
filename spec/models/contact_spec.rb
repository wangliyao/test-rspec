require 'spec_helper'

describe Contact do
  it "is valid with a firstname ,lastname an email" do
    # contact = Contact.new(
    #     firstname: "Aaron",
    #     lastname: "Zs",
    #     email: "tester@gmail.com"
    # )
    expect(build(:contact)).to be_valid
  end

  #测试是否会出现预期的错误，进行数据验证
  it "invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  it "invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid with a duplicate email address" do
    # Contact.create(
    #            firstname:'Joe',lastname:'Tester',
    #            email:'tester@example.com'
    # )

    create(:contact,email:'tester@example.com')
    contact =build(:contact,email:'tester@example.com')
    # contact = Contact.new(
    #                      firstname:'Jane',lastname:'Tester',
    #                      email:'tester@example.com'
    # )
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a sorted array of result that match" do
    smith = Contact.create(
                       firstname: 'John', lastname:'Smith',
                       email: 'jsmith@example.com'
    )
    jones = Contact.create(
                       firstname: 'Tim', lastname:'Jones',
                       email: 'tjones@example.com'

    )
    johnson= Contact.create(
                        firstname: 'John', lastname:'Johnson',
                        email: 'jjohnson@example.com'
    )
    expect(Contact.by_letter('J')).to eq [johnson,jones]
  end

  describe "filter last name bu letter" do
    before :each do
      @smith = Contact.create(
          firstname: 'John', lastname:'Smith',
          email: 'jsmith@example.com'
      )
      @jones = Contact.create(
          firstname: 'Tim', lastname:'Jones',
          email: 'tjones@example.com'

      )
      @johnson= Contact.create(
          firstname: 'John', lastname:'Johnson',
          email: 'jjohnson@example.com'
      )
    end

    context "matching letter" do
        it "returns a sorted array of result that match" do
          expect(Contact.by_letter('J')).to eq [@johnson , @jones]
        end
    end

    context "no-matching letter" do
        it "only returns contacts with the provided starting letter" do
          expect(Contact.by_letter("J")).to_not include @smith
        end
    end

  end

  #contact关联phone，callback之后是否成功生成相应的数据
  it"has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end
end
