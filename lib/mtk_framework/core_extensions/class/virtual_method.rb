# frozen_string_literal: true

class Class
  def virtual_method(*args)
    args.each do |method_name|
      define_method(method_name) do
        raise NotImplementedError, "#{self.class.name}##{method_name} is a virtual method!"
      end
    end
  end
end
