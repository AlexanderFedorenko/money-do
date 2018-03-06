# frozen_string_literal: true

json.extract! account,
              :id, :name, :kind, :ancestry, :initial_balance, :created_at, :updated_at
json.url account_url(account, format: :json)
