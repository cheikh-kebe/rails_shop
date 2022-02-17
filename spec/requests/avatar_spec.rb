require 'rails_helper'

RSpec.describe "Avatars", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/avatar/create"
      expect(response).to have_http_status(:success)
    end
  end

end
