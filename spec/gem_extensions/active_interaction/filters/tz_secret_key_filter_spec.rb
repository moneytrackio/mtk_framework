# frozen_string_literal: true

RSpec.describe ActiveInteraction::TzSecretKeyFilter, :filter do # rubocop: disable RSpec/FilePath
  it_behaves_like "a tz filter",
                  valid: [Faker::Blockchain::Tezos.secret_key],
                  invalid: ["invalid", 10, Faker::Blockchain::Tezos.public_key]
end
