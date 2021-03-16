# frozen_string_literal: true

# External libs
require 'active_interaction'
require 'tezos_client'
require 'active_support/core_ext/hash/indifferent_access'

# Gem extensions
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/abstract_tz_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/hash_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_account_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_contract_address_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_operation_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_public_key_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_secret_key_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/filters/tz_signature_filter.rb'
require_relative 'mtk_framework/gem_extensions/active_interaction/base.rb'

# Core extensions
require_relative 'mtk_framework/core_extensions/array/except.rb'
require_relative 'mtk_framework/core_extensions/class/virtual_method.rb'
require_relative 'mtk_framework/core_extensions/hash/rename_keys.rb'

require_relative 'mtk_framework/railtie.rb' if defined?(Rails::Railtie)
