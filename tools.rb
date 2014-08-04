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

module Timemarks_parse
  def self.get_membership_function(file_name)
    mf_data = Hash.new
    f = File.open(file_name, 'r')
    slice = nil
    while(slice = f.getc)
      data = slice.chomp.split(' ')
      (data[0].to_f..data[1].to_f).step(1.0/300.0) do |i|
        mf_data[i] = data[3].to_i
      end
    end
    f.close
    mf_data
  end
end