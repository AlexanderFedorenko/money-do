# frozen_string_literal: true

class Account < ApplicationRecord
  monetize :initial_balance_cents
end
