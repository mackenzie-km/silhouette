class Fact < ActiveRecord::Base
  belongs_to :contact

  def self.normalize(facts)
    details = []
    binding.pry
    each_fact = facts.split("+")
    each_fact.each do |fact|
      if fact.include?("[" && "]")
        chunk = [fact.slice!(/\[.{2,}\]/), fact]
        chunk[0].gsub!(/\]/, "")
        chunk[0].gsub!(/\[/, "")
        chunk[0].downcase!
        chunk[0].gsub!(" ", "_") if chunk[0].include?(" ")
        key = chunk[0].strip
        value = chunk[1].strip
        details << [key, value]
      end 
    end
    details
  end

end
