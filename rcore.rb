require 'erb'
class RCore
  attr_accessor :io
  def initialize
    self.io = []
  end

  def render(a, b)
    io[-1] << ERB.new(a).result(b.instance_eval{binding})
  end

  def resolve(a)
    a
  end
end



