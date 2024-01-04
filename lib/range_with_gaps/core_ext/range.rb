class Range
  include RangeWithGaps::RangeMath

  %i[first last].each do |method_name|
    original_method = instance_method(method_name)
    org_size = instance_method(:size)

    define_method(method_name) do |*args, &block|
      _size = org_size.bind(self).call
      if _size.nil? || _size.infinite?
        nil
      else
        original_method.bind(self).call(*args, &block)
      end
    end
  end
end
