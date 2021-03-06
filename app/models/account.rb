# frozen_string_literal: true

class Account < ApplicationRecord
  enum kind: { income: 1, expense: 2, storage: 3, debt: 4 }

  monetize :initial_balance_cents

  has_ancestry orphan_strategy: :rootify

  validates :name, :kind, presence: true
  validates :initial_balance, numericality: true
end
