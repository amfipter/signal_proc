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
