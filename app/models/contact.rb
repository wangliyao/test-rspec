class Contact < ActiveRecord::Base

  has_many :phones

  validates_presence_of :firstname,:lastname
  validates_uniqueness_of :email

  def name
    [firstname,lastname].join(' ')
  end

  def self.by_letter(letter)
    where("lastname LIKE ?","#{letter}%").order(:lastname)
  end
end
