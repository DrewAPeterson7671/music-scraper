require 'rails_helper'

RSpec.describe "AnnualRanks", type: :request do
  describe "GET /annual_ranks" do
    it "works! (now write some real specs)" do
      get annual_ranks_path
      expect(response).to have_http_status(200)
    end
  end
end
