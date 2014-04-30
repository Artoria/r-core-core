class RTCEnv
  IOStack = Struct.new(:next, :io)
  attr_accessor :io
  def initialize(&block)
    self.io = {}
    @argss = {}
    self.begin
    instance_exec &block
  end

  def begin
    io[:$top] = ""
    @stack = IOStack.new(nil, io[:$top])   
  end

  def random
    @id ||= 0
    @id += 1
    "__id#{@id}"
  end

  def where(caption = random)
    @argss[caption] = @args[-1]
    write "<%= render #{caption.inspect} %>"
  end

  def end
    render :$top
  end

  def render caption
    ERB.new(io[caption]).result(binding)
  end

  
  def write *a
    @stack.io << a.join
  end

  def pushargs(*a)
    @args ||= []
    @args << a
    a  
  end

  def popargs
    @args.pop  
  end

  def file(a, b)
    write "FILE *fp = fopen(#{a.inspect}, #{b.inspect});\n"
    yield *pushargs("fp")
    popargs
    write "fclose(fp);\n"
  end

  def reopen(caption)
    @stack = IOStack.new(@stack, io[caption] ||= "")
    yield *@argss[caption]
    @stack = @stack.next
  end
end
