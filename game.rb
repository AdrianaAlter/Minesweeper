first = ("A".."I").to_a
second = ("A".."I").to_a
tile_names = []

first.each do |firstletter|
  second.each do |secondletter|
    tile_names << "#{firstletter}#{secondletter}"
  end
end

tile_hash = Hash.new
tile_names.each { |name| tile_hash[name] = nil }
p tile_hash
