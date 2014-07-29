module Proc_main
  include Proc_work
  def self.main()
    

    data = Proc_work.read($data_name, 1)
    noise = Proc_work.read($noise_name, 1)

    noise_n = Proc_work.narray_create_float(noise)
    data_n = Proc_work.narray_create_float(data)

    noise_mean = noise_n.mean
    data_n -= noise_mean
    noise_n -= noise_mean
    noise_mean_abs = noise_n.clone.abs.mean
    # pp noise_mean_abs
    # exit





    $noise_cycle.times do
      data_n = Proc_work.simple_noise_reduct(data_n, noise_mean_abs)
      noise_n = Proc_work.simple_noise_reduct(noise_n, noise_mean_abs)
      noise_mean_abs = noise_n.clone.abs.mean
    end

    noise_proc = Proc_work.narray_to_array(noise_n)


    data_proc = Proc_work.narray_to_array(data_n)



    puts data_proc


  end
end
