module Proc_main
  def main.self()
    include Proc_work

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
end
