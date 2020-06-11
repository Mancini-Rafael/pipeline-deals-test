# frozen_string_literal: true

class Api::V1::DealsController < ApplicationController
  def index
    result = Api::V1::FetchDeals.call
    if result.success?
      render json: result.response
    else
      render json: { errors: result.errors }, status: :service_unavailable
    end
  end
end
