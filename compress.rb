class Signal_compress
  def initialize(data)
    @data = data
  end

  def comp(size)
    data = Array.new 
    i = 0
    while i < @data.size do 
      data.push @data[i]
      i += size
    end
    data 
  end
end



