# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_cookie_notice.html.erb', type: :view do
  before do
    ENV['GREAT_GOV_URL'] = 'https://great.gov.uk'
  end

  it 'contains a link to privacy and cookies page' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('.link')[0]['href']).to eq('https://great.gov.uk/privacy-and-cookies')
  end
end

RSpec.describe 'export_components/_cookie_domain_meta.html.erb', type: :view do
  it 'renders env var' do
    ENV['PRIVACY_COOKIE_DOMAIN'] = '.test.gov.uk'
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('meta')[0]['value']).to eq('.test.gov.uk')
  end

  it 'renders default value' do
    ENV.delete('PRIVACY_COOKIE_DOMAIN')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('meta')[0]['value']).to eq('.great.gov.uk')
  end
end
