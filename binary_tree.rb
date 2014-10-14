class BinaryTree
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def evaluate
    case @value
    when "*"
      if self.right.value == "0"
        0
      elsif self.left.value == "0"
        0
      else
        self.left.evaluate * self.right.evaluate
      end
    when "+"
      self.left.evaluate + self.right.evaluate
    when /-?\d+/
      self.value.to_i
    end
  end
end
