class Array
  def all_empty?
    all? { |ele| ele == ' . ' }
  end

  def all_same?
    all? { |ele| ele == self[0] }
  end
end