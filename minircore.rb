require 'erb'
class RCore
  def render(a, b)
    ERB.new(resolve(a)).result(b.instance_eval{binding})
  end

  def resolve(a)
    a
  end
end
