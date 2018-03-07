# frozen_string_literal: true

FactoryBot.define do
  factory :income_account, class: Account do
    name 'Income account'
    kind :income
    ancestry ''
    initial_balance 0
  end

  factory :expense_account, class: Account do
    name 'Expense account'
    kind :expense
    ancestry ''
    initial_balance 0
  end

  factory :storage_account, class: Account do
    name 'Storage account'
    kind :storage
    ancestry ''
    initial_balance 0
  end

  factory :debt_account, class: Account do
    name 'Debt account'
    kind :debt
    ancestry ''
    initial_balance 0
  end
end
