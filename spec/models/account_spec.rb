# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'has valid factories' do
    expect(FactoryBot.create(:account, :income)).to be_valid
    expect(FactoryBot.create(:account, :expense)).to be_valid
    expect(FactoryBot.create(:account, :storage)).to be_valid
    expect(FactoryBot.create(:account, :debt)).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
    it { should define_enum_for(:kind) }
    it { should validate_numericality_of(:initial_balance) }
  end
end
