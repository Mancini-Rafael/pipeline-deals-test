# frozen_string_literal: true

require 'uri'
require 'json'
require 'net/http'

class Api::V1::FetchDeals
  include Interactor

  def call
    build_request
    make_request
    parse_response
  end

  def build_request
    http_handler = Net::HTTP.new(url.host, url.port)
    http_handler.use_ssl = true
    http_handler.verify_mode = OpenSSL::SSL::VERIFY_NONE
    context.http = http_handler
    request_raw = Net::HTTP::Get.new(url)
    context.request = request_raw
  end

  def make_request
    request = context.http.request(context.request)
    context.raw_response = request.code == '200' ? JSON.parse(request.response.body) : context.fail!(errors: ['Request returned an error'])
  end

  def parse_response
    context.response = context
                       .raw_response
                       .entries[0][1]
                       .map { |e|
                        { id: e.dig('id'),
                          name: e.dig('name'),
                          percent: e.dig('deal_stage', 'percent') } }
  end

  def url
    # The best approach would be Rails.application.credentials[:pipeline_deals_endpoint/pipeline_deals_api_key],
    # however, then I would need to share my master.key and the whole process would not be seamless
    # url = URI.parse(Rails.application.credentials[:pipeline_deals_endpoint] + "deals.json?api_key=#{Rails.application.credentials[:pipeline_deals_api_key]}")
    url = URI.parse(ENV.fetch("PIPELINE_DEALS_ENDPOINT") + "deals.json?api_key=#{ENV.fetch("PIPELINE_DEALS_API_KEY")}")
  end
end
