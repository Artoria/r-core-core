
class RCore
  def render(a, b = self)
    ERB.new(resolve(a)).result(b.instance_eval{binding})
  end

  def resolve(a)
    a
  end
end

class RQ < RCore
  def initialize(dir)
    @dir = File.join("./R", dir)
  end
  def resolve(f)
    File.read(File.join(@dir, f) + ".txt").force_encoding("UTF-8")
  end
  def value
    render 'main', self
  end
end
