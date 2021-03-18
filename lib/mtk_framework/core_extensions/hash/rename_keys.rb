# frozen_string_literal: true

class Hash
  def rename_keys(keys_replacement_hash)
    transform_keys do |key|
      next key unless keys_replacement_hash.key?(key)

      keys_replacement_hash[key]
    end
  end
end
