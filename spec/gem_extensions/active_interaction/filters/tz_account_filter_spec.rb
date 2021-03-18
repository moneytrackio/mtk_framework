# frozen_string_literal: true

RSpec.describe ActiveInteraction::TzAccountFilter, :filter do # rubocop: disable RSpec/FilePath
  it_behaves_like "a tz filter",
                  valid: [Faker::Blockchain::Tezos.account],
                  invalid: ["invalid", Faker::Blockchain::Tezos.secret_key]
end
