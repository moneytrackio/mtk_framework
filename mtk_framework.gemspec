# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: mtk_framework 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mtk_framework".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["othmane el kesri".freeze]
  s.date = "2021-03-18"
  s.email = "dev@moneytrack.io".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/mtk_framework.rb",
    "lib/mtk_framework/active_interaction_concerns/i18nable.rb",
    "lib/mtk_framework/active_interaction_concerns/interruptable.rb",
    "lib/mtk_framework/active_interaction_concerns/loggable.rb",
    "lib/mtk_framework/active_interaction_concerns/rescuable.rb",
    "lib/mtk_framework/active_interaction_concerns/updatable_object.rb",
    "lib/mtk_framework/active_interaction_mocks/interaction_group_mocks_helper.rb",
    "lib/mtk_framework/active_interaction_mocks/interaction_mocks_helper.rb",
    "lib/mtk_framework/active_interaction_mocks/mocks_loader.rb",
    "lib/mtk_framework/active_interaction_params.rb",
    "lib/mtk_framework/active_interaction_params/parametrize_filter.rb",
    "lib/mtk_framework/core_extensions/array/except.rb",
    "lib/mtk_framework/core_extensions/class/virtual_method.rb",
    "lib/mtk_framework/core_extensions/hash/rename_keys.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/base.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/abstract_tz_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/hash_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_account_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_contract_address_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_operation_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_public_key_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_secret_key_filter.rb",
    "lib/mtk_framework/gem_extensions/active_interaction/filters/tz_signature_filter.rb",
    "lib/mtk_framework/locale/active_interaction.fr.yml",
    "lib/mtk_framework/locale/fr.yml",
    "lib/mtk_framework/railtie.rb",
    "mtk_framework.gemspec",
    "spec/active_interaction_concerns/interruptable_spec.rb",
    "spec/active_interaction_concerns/loggable_spec.rb",
    "spec/application_interaction_spec.rb",
    "spec/fake_app.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/moneytrackio/mtk_framework".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Moneytrack's gems extensions and monkey patches.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<active_interaction>.freeze, ["~> 4.0"])
      s.add_runtime_dependency(%q<grape>.freeze, ["~> 1.3.0"])
      s.add_runtime_dependency(%q<rails>.freeze, ["~> 6.0.0"])
      s.add_runtime_dependency(%q<rspec-rails>.freeze, ["~> 3.8.2"])
      s.add_runtime_dependency(%q<tezos_client>.freeze, ["~> 1.3.5"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    else
      s.add_dependency(%q<active_interaction>.freeze, ["~> 4.0"])
      s.add_dependency(%q<grape>.freeze, ["~> 1.3.0"])
      s.add_dependency(%q<rails>.freeze, ["~> 6.0.0"])
      s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.8.2"])
      s.add_dependency(%q<tezos_client>.freeze, ["~> 1.3.5"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    end
  else
    s.add_dependency(%q<active_interaction>.freeze, ["~> 4.0"])
    s.add_dependency(%q<grape>.freeze, ["~> 1.3.0"])
    s.add_dependency(%q<rails>.freeze, ["~> 6.0.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.8.2"])
    s.add_dependency(%q<tezos_client>.freeze, ["~> 1.3.5"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
  end
end

