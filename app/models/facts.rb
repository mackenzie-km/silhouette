class Fact < ActiveRecord::Base
  belongs_to :contact

  def self.normalize(facts)
    details = []
    each_fact = facts.split("+")
    if !!facts.scan(/\[[\w]+\]/i)
      each_fact.each do |fact|
        chunk = [fact.slice!(/\[.{2,}\]/), fact]
        chunk[0].gsub!(/\]/, "")
        chunk[0].gsub!(/\[/, "")
        chunk[0].downcase!
        if chunk[0].include?(" ")
          chunk[0].gsub!(" ", "_")
        end
        key = chunk[0].strip
        value = chunk[1].strip
        details << [key, value]
      end
    end
    details
  end

end
