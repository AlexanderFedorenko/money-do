# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let(:headers) do
    { 'Accept': 'application/json' }
  end

  let(:valid_params) do
    attributes_for(:account, :storage)
  end

  let(:invalid_params) do
    { account: attributes_for(:account, :storage, name: nil) }
  end

  let(:existing_account) do
    create(:account, :income)
  end

  let(:non_existing_account) do
    build(:account, :debt, id: 'bda1c21568c2-c788-bbc4-0ea7-2f557902')
  end

  describe 'GET /accounts' do
    context 'when there are no accounts created' do
      before do
        get accounts_path, headers: headers
      end

      it 'responds with an empty list' do
        expect(json_response.size).to eq(0)
      end

      it 'responds with correct status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there are accounts created' do
      before do
        create(:account, :expense)
        create(:account, :income)

        get accounts_path, headers: headers
      end

      it 'responds with a list of accounts' do
        expect(json_response.size).to eq(2)
      end

      it 'responds with correct status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /accounts' do
    context 'with valid params' do
      subject do
        post accounts_path, params: { account: valid_params }, headers: headers
      end

      it 'creates account' do
        expect { subject }.to change(Account, :count).by(1)
      end

      it 'responds with created account' do
        subject
        expect(json_response[:name]).to eq valid_params[:name]
      end

      it 'responds with correct status' do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      subject do
        post accounts_path, params: { account: invalid_params }, headers: headers
      end

      it 'creates account' do
        expect { subject }.not_to change(Account, :count)
      end
      it 'responds with correct status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /accounts/:id' do
    context 'when account exists' do
      before do
        get account_path(existing_account.id), headers: headers
      end

      it 'responds with correct status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with account' do
        expect(json_response[:name]).to eq existing_account.name
      end
    end

    context 'when account not found' do
      it 'responds with correct status' do
        get account_path(non_existing_account.id), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /accounts/:id' do
    context 'when account exists' do
      before(:all) do
        create(:account, :debt)
      end
      context 'with valid params' do
        subject do
          put account_path(existing_account.id), params: { account: { name: 'New name' } }, headers: headers
          existing_account.reload
        end

        it 'updates account' do
          expect { subject }.to change(existing_account, :name).to 'New name'
        end

        it 'responds with updated account' do
          subject
          expect(json_response[:name]).to eq 'New name'
        end

        it 'responded with correct status' do
          subject
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid params' do
        subject do
          put account_path(existing_account.id), params: { account: { name: nil } }, headers: headers
          existing_account.reload
        end

        it 'does not updates account' do
          subject
          expect { subject }.not_to change(existing_account, :name).from existing_account.name
        end

        it 'responds with correct status' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when account not found' do
      it 'responds with correct status' do
        put account_path(non_existing_account.id), params: { account: { name: 'New name' } }, headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /accounts/:id' do
    context 'when account exists' do
      before do
        existing_account
      end

      subject do
        delete account_path(existing_account.id), headers: headers
      end

      it 'deletes an account' do
        expect { subject }.to change(Account, :count).by(-1)
      end
    end

    context 'when account not found' do
      it 'responds with correct status' do
        delete account_path(non_existing_account.id), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
