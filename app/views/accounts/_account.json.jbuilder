# frozen_string_literal: true

json.extract! account,
              :id, :name, :type, :ancestry, :initial_balance, :created_at, :updated_at
json.url account_url(account, format: :json)
