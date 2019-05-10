class Fact < ActiveRecord::Base
  validates :topic, :format => { with: /[a-zA-Z0-9]{1,}/ }
  validates :information, :format => { with: /[a-zA-Z0-9]{1,}/ }
  belongs_to :contact

  def self.normalize(facts)
    details = []
    each_fact = facts.split(",")
    each_fact.each do |fact|
      chunk = [fact.slice!(/\[.{2,}\]/), fact]
      chunk[0].gsub!(/\]/, "")
      chunk[0].gsub!(/\[/, "")
      chunk[0].downcase
      if chunk[0].include?(" ")
        chunk[0].gsub!(" ", "_")
      end
      key = chunk[0].strip
      value = chunk[1].strip
      details << [key, value]
    end
    details
  end

end
