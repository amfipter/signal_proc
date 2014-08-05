module Tools
  def self.data_print(data, file_name)
    f = File.new(file_name, 'w')
    f.puts data 
    f.close 
    nil
  end

  def self.data_print2(col1, col2, file_name)
    f = File.new(file_name, 'w')
    col1.size.times do |i| 
      f.puts "#{col1[i]} #{col2[i]}"
    end
    f.close 
    nil 
  end
end

class Timemarks
  def initialize(file_name)
    local_eps = 0.001
    max = 0.0
    @mf_data = Hash.new
    f = File.open(file_name, 'r')
    slice = nil
    while(slice = f.gets)
      data = slice.chomp.split(' ')
      # puts data.to_s
      # puts slice 
      # (data[0].to_f..data[1].to_f).step(1.0/300.0) do |i|
      #   # puts i 
      #   mf_data[i] = data[2].to_i
      # end
      @mf_data[(data[0].to_f - local_eps).round(3)] = 0
      @mf_data[data[0].to_f] = data[2].to_i
      @mf_data[data[1].to_f] = data[2].to_i
      @mf_data[(data[1].to_f + local_eps).round(3)] = 0
      max = data[1].to_f - data[0].to_f if data[1].to_f - data[0].to_f > max
      if(data[1].to_f - data[0].to_f > 1.0)
        puts data[0]
      end
      # puts local_eps
      # puts data[0].to_f.to_s
      # puts (data[0].to_f - local_eps).to_s
      # puts data[1].to_f.to_s
      # puts (data[1].to_f + local_eps).to_s
      # sleep 1
    end
    puts max 
    f.close
  end

  def get_membership_function()
    @mf_data
  end

end