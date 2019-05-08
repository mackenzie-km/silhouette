class Contact < ActiveRecord::Base
  belongs_to :user

  def full_name
    self.first_name + " " + self.last_initial + "."
  end

  def slug
    "#{self.first_name}-#{self.last_initial}".downcase
  end

  def self.find_by_slug(slug)
    found = slug.split("-")
    Contact.find_by(:first_name => found[0].titleize, :last_initial => found[1].titleize)
  end

end
