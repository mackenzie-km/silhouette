class Contact < ActiveRecord::Base
  validates :first_name, :format => { with: /[a-z0-9]/i }
  validates :first_name, length: 2..10
  validates :last_initial, :format => { with: /[a-z0-9]/i }
  validates :last_initial, length: 1..3
  belongs_to :user
  has_many :facts

  def full_name
    self.first_name + " " + self.last_initial + "."
  end

  def slug
    "#{self.first_name}-#{self.last_initial}".downcase
  end

end
