# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: Account do
    ancestry nil
    initial_balance 0

    trait :income do
      name 'Income account'
      kind :income
    end

    trait :expense do
      name 'Expense account'
      kind :expense
    end

    trait :storage do
      name 'Storage account'
      kind :storage
    end

    trait :debt do
      name 'Debt account'
      kind :debt
    end
  end
end
