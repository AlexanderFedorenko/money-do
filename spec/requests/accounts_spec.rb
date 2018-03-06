# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:headers) do
    { 'Accept': 'application/json', 'Content-Type': 'application/json' }
  end

  describe 'GET /accounts' do
    it 'works! (now write some real specs)' do
      get accounts_path, headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
