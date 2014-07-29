module Proc_work
  def read(name, col = 0)
    file = File.open(name, 'r')
    data = Array.new
    slice = nil
    while(slice = file.gets)
      data.push (slice.chomp.split ' ')[col].to_f
    end
    file.close
    data
  end

  def narray_create_float(array_data)
    narray = NArray.float(array_data.size)
    array_data.size.times do |i|
      narray[i] = array_data[i]
    end
    narray
  end

  def narray_to_array(narray)
    out = Array.new 
    narray.each do |el|
      out.push el 
    end
    out
  end

  def simple_noise_reduct(data, mean_abs)
    data.length.times do |i|
      data[i] += mean_abs if data[i] < 0
      data[i] -= mean_abs if data[i] > 0
    end
    data 
  end

  def find_noise(ndata)
    nil
  end

end