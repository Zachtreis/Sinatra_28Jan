# require 'bundler'
# Bundler.require

class Gossip

  attr_accessor :author, :content, :id

  def initialize(author, content)
    @author = author
    @content = content
  end


  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |line|
      all_gossips << Gossip.new(line[0], line[1]) 
    end
    # print all_gossips
    return all_gossips
  end

  def self.find(id)
    temp = open("./db/gossip.csv").each_line.take(id).last.split(",")
    return temp[0], temp[1], id
  end

  def self.edit(id)
    temp = open("./db/gossip.csv").each_line.take(id).last.split(",")
    return temp[1], id
  end


  def self.update(id, string)
    CSV.open("./db/gossip_temp.csv", "a") do |file|
      Gossip.all.each_with_index do |gossip, i|
        if i+1 != id
          file << [gossip.author, gossip.content]
        else
          file << [gossip.author, "#{string}"]
        end
      end
    end
    File.delete("./db/gossip.csv")
    File.rename("./db/gossip_temp.csv", "db/gossip.csv")
  end

  #     CSV.read("./db/gossip.csv").each do |line|
  #     # open("./db/gossip.csv").each_line do |ligne|
  #     # CSV.foreach("./db/gossip.csv") do |ligne|
  #     <% gossips.each_with_index do |gossip, i| %>
  #     <p>
  #       <%= gossip.author %><br/>
  #       <%= gossip.content %><br />
  #       if $. != id
  #         file << Gossip.new(line[0], line[1]) 
  #       else
  #         file << Gossip.new(line[0], [ligne[0], string]
  #         old_content = ligne[1] 
  #       end
  #     end
  #   end
  #   File.delete("./db/gossip.csv")
  #   File.rename("./db/gossip_temp.csv", "db/gossip.csv")
  #   return old_content, id
  # end
    




end

# Gossip.all

