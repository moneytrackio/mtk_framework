# frozen_string_literal: true

RSpec.shared_examples_for "a tz filter" do |values|
  include_context "filters"
  it_behaves_like "a filter"

  describe "#cast" do
    let(:result) { filter.send(:cast, value, nil) }

    values.fetch(:valid, ["please provide valid values"]).each do |valid_value|
      context "with #{valid_value} as a valid value" do
        let(:value) { valid_value }

        it "returns the value" do
          expect(result).to eql value
        end
      end
    end

    values.fetch(:invalid, ["please provide invalid values"]).each do |invalid_value|
      context "with #{invalid_value} as an invalid String" do
        let(:value) { invalid_value }

        it "raises an error" do
          expect do
            result
          end.to raise_error ActiveInteraction::InvalidValueError
        end
      end
    end

    context "with nil value" do
      let(:value) { nil }

      context "optional" do
        include_context "optional"

        it "returns the default" do
          expect(result).to eql options[:default]
        end
      end

      context "required" do
        include_context "required"

        it "raises an error" do
          expect do
            result
          end.to raise_error ActiveInteraction::MissingValueError
        end
      end
    end
  end

  describe "#database_column_type" do
    it "returns :string" do
      expect(filter.database_column_type).to be :string
    end
  end
end
