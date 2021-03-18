# frozen_string_literal: true

RSpec.describe ActiveInteraction::TzOperationFilter, :filter do # rubocop: disable RSpec/FilePath
  it_behaves_like "a tz filter",
                  valid: [Faker::Blockchain::Tezos.operation],
                  invalid: ["invalid", Faker::Blockchain::Tezos.secret_key]
end
