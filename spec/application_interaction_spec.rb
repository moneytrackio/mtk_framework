# frozen_string_literal: true

# require_relative 'spec_helper'
# require 'active_interaction'
# require 'mtk_framework'
# require 'pry'

class ApplicationInteraction < ActiveInteraction::Base
  include MtkFramework::ActiveInteractionConcerns::I18nable
  include MtkFramework::ActiveInteractionConcerns::Interruptable
  include MtkFramework::ActiveInteractionConcerns::Loggable
  include MtkFramework::ActiveInteractionConcerns::Rescuable
  include MtkFramework::ActiveInteractionConcerns::UpdatableObject
end

RSpec.describe ApplicationInteraction do
end
