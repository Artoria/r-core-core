env = RTCEnv.new do 
  def forrange(a, b)
    id = random
    pushargs id
    write "for(int #{id}=#{a}; #{id}<#{b}; ++#{id}){\n"
    caption = where
    write "}"

    if block_given?
      yield id
      popargs
    else
      popargs
      caption
    end
  end

 
  forrange(1, 5) do |id| 
    write "printf(\"%d\", #{id});\n"
  end 
end

puts env.end
