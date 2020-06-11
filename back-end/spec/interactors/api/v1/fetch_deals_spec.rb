require 'rails_helper'

RSpec.describe Api::V1::FetchDeals, type: :interactor do
  subject(:result) { Api::V1::FetchDeals.call }

  describe ".call" do
    context "when the api fetch is successfull" do
      before(:each) {
        mock_response = {
          "entries": [
            {
              "id": 123456,
              "name": "Great Deal",
              "deal_stage": {
                "percent": 50
              }
            }
          ],
          "pagination": {
            "page": 1,
            "total": 100
          }
        }
        stub_request(:get, "#{ENV.fetch("PIPELINE_DEALS_ENDPOINT")}" + "deals.json?api_key=#{ENV.fetch("PIPELINE_DEALS_API_KEY")}"
        to_return(body: mock_response.to_json, status: 200)
      }
      
      it "runs without errors"do
        expect(result.success?).to eq(true)
      end

      it "returns a parsed deals json object" do
        parsed_response = [{id: 123456, name: "Great Deal", percent: 50}]
        expect(result.response).to eq(parsed_response)
      end
    end
    
    context "when the api fetch is unsuccessfull" do
      before(:each) {
        stub_request(:get, "#{ENV.fetch("PIPELINE_DEALS_ENDPOINT")}" + "deals.json?api_key=#{ENV.fetch("PIPELINE_DEALS_API_KEY")}"
        to_return(body: "Error", status: 500)
      }
      it "fails graciously"do
        expect(result.success?).to eq(false)
      end

      it "returns appropriate error messages"do
        expect(result.errors.include?("Request returned an error")).to eq(true)
      end
    end
  end
end