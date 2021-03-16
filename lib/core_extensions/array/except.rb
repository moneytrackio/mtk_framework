# frozen_string_literal: true

class Array
  def except(*fields)
    self - fields
  end
end
