module Proc_main
    def self.main()

    data = read($data_name, 1)
    data_time = read($data_name, 0)
    noise = read($noise_name, 1)

    noise_n = narray_create_float(noise)
    data_n = narray_create_float(data)

    noise_mean = noise_n.mean
    data_n -= noise_mean
    noise_n -= noise_mean
    noise_mean_abs = noise_n.clone.abs.mean
    # pp noise_mean_abs
    # exit

    $NOISE_CYCLE.times do
      simple_noise_reduct(data_n, noise_mean_abs)
      simple_noise_reduct(noise_n, noise_mean_abs)
      noise_mean_abs = noise_n.clone.abs.mean
    end

    void_noise_reduct(data_n)
    middle_noise_reduct(data_n, noise_n.abs.max * 2.0)
    # experimental_noise_reduct(data_n, 1.0)
    big_interval_noise_reduct(data_n, 0.5, 15000)

    noise_proc = narray_to_array(noise_n)


    data_proc = narray_to_array(data_n)

    return data_time, data_proc
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

  def self.void_noise_reduct(data, void_noise_abs = 0.001)
    data.length.times do |i|
      data[i] = 0 if data[i].abs <= void_noise_abs
    end
    nil
  end

  def self.middle_noise_reduct(data, middle_noise_abs = 0.025)
    # STDERR.puts middle_noise_abs
    data.length.times do |i|
      data[i] = 0 if data[i].abs <= middle_noise_abs + $EPS
    end
    nil
  end

  def self.experimental_noise_reduct(data, ex_noise_reduct)
    data.length.times do |i|
      data[i] = 0 if data[i].abs >= ex_noise_reduct + $EPS
    end
    nil
  end

  def self.big_interval_noise_reduct(data, bi_noise_reduct, interval)
    data.length.times do |i|
      interval_remove(data, i, interval) if data[i].abs >= bi_noise_reduct
    end
    nil
  end

  def self.interval_remove(data, index, interval)
    min = index - interval
    min = 0 if min < 0

    max = index+interval
    max = data.length - 1 if max >= data.length
    data[min..max] = 0.0
    # STDERR.puts data[(index-interval)..(index+interval)]
    nil
  end
end
