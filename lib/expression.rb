require "stack"

class UndefinedVariableError < StandardError; end



class Expression

  # Returns a new expression
  def initialize(expr)
    @expr = expr
  end

  # Evaluates an expression, simplifying if possible.
  #
  # @param bindings [Hash] a map of variable names to concrete values
  # @return [Expression] Returns a possibly-simplified Expression
  def evaluate(bindings = {})
    stack = Stack.new

    tokens.each do |token|
      if numeric?(token)
        stack.push(token.to_i)
      elsif variable?(token)
        raise UndefinedVariableError if bindings[token.to_sym].nil?
        stack.push(bindings[token.to_sym])
      elsif token == "*"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs * rhs)
      elsif token == "+"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs + rhs)
      else
        raise "hmmm what token is this?"
      end
    end

    stack.pop
  end

  private

  def tokens
    @expr.split(" ")
  end

  def numeric?(token)
    token =~ /^-?\d+$/
  end

  def variable?(token)
    token =~ /^[a-z]/
  end
end
