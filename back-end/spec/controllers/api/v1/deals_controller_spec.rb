require 'rails_helper'

RSpec.describe Api::V1::DealsController, type: :controller do

  describe "GET /index" do
    context "when requesting deals" do
      it "calls the interactor to fetch the API responses" do
        allow(Api::V1::FetchDeals).to receive(:call).and_return(OpenStruct.new({success?: true, deals: []}))
        get :index
        expect(response).to have_http_status(:success)
      end
      context "is unsuccessfull" do
        it "returns the appropriate status_code" do
          allow(Api::V1::FetchDeals).to receive(:call).and_return(OpenStruct.new({success?: false}))
          get :index
          expect(response).to have_http_status(:error)
        end
      end
    end
  end
end
