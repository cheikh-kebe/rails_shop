class ApiKey
  PUBLIC_KEY = Rails.application.credentials.marvel[:marvel_public_api_key]
  PRIVATE_KEY = Rails.application.credentials.marvel[:marvel_private_api_key]
end
