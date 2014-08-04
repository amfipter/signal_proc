module Tools
  def self.data_print(data, file_name)
    f = File.new(file_name, 'w')
    f.puts data 
    f.close 
  end
end
