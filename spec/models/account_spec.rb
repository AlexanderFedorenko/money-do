# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'has valid factories' do
    expect(FactoryBot.create(:income_account)).to be_valid
    expect(FactoryBot.create(:expense_account)).to be_valid
    expect(FactoryBot.create(:storage_account)).to be_valid
    expect(FactoryBot.create(:debt_account)).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
    it { should define_enum_for(:kind) }
    it { should validate_numericality_of(:initial_balance) }
  end
end
