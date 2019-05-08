class Contact < ActiveRecord::Base
  belongs_to :user

  def full_name
    self.first_name + " " + self.last_initial + "."
  end

  def profile
    "/#{self.id}"
  end

  def slug
    "#{self.first_name}-#{self.last_initial}".downcase
  end

end
