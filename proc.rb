module Proc_main
  include Proc_work
  def self.main()   

    data = read($data_name, 1)
    noise = read($noise_name, 1)

    noise_n = narray_create_float(noise)
    data_n = narray_create_float(data)

    noise_mean = noise_n.mean
    data_n -= noise_mean
    noise_n -= noise_mean
    noise_mean_abs = noise_n.clone.abs.mean
    # pp noise_mean_abs
    # exit

    $noise_cycle.times do
      data_n = simple_noise_reduct(data_n, noise_mean_abs)
      noise_n = simple_noise_reduct(noise_n, noise_mean_abs)
      noise_mean_abs = noise_n.clone.abs.mean
    end

    noise_proc = narray_to_array(noise_n)


    data_proc = narray_to_array(data_n)



    puts data_proc


  end

  private

  def self.read(name, col = 0)
    file = File.open(name, 'r')
    data = Array.new
    slice = nil
    while(slice = file.gets)
      data.push (slice.chomp.split ' ')[col].to_f
    end
    file.close
    data
  end

  def self.narray_create_float(array_data)
    narray = NArray.float(array_data.size)
    array_data.size.times do |i|
      narray[i] = array_data[i]
    end
    narray
  end

  def self.narray_to_array(narray)
    out = Array.new 
    narray.each do |el|
      out.push el 
    end
    out
  end

  def self.simple_noise_reduct(data, mean_abs)
    data.length.times do |i|
      data[i] += mean_abs if data[i] < 0
      data[i] -= mean_abs if data[i] > 0
    end
    data 
  end

  def self.find_noise(ndata)
    nil
  end
end
