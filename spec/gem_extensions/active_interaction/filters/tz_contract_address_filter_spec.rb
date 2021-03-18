# frozen_string_literal: true

RSpec.describe ActiveInteraction::TzContractAddressFilter, :filter do # rubocop: disable RSpec/FilePath
  it_behaves_like "a tz filter",
                  valid: [Faker::Blockchain::Tezos.contract],
                  invalid: ["invalid", Faker::Blockchain::Tezos.secret_key]
end
