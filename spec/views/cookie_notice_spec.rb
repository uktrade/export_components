# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_cookie_notice.html.erb', type: :view do
  before do
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :GREAT_GOV_URL).and_return('https://great.gov.uk')
  end

  it 'contains a link to privacy and cookies page' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('.link')[0]['href']).to eq('https://great.gov.uk/privacy-and-cookies')
  end
end

RSpec.describe 'export_components/_cookie_domain_meta.html.erb', type: :view do
  it 'renders env var' do
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :PRIVACY_COOKIE_DOMAIN).and_return('.test.gov.uk')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('meta')[0]['value']).to eq('.test.gov.uk')
  end

  it 'renders default value' do
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :PRIVACY_COOKIE_DOMAIN).and_return(nil)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('meta')[0]['value']).to eq('.great.gov.uk')
  end
end
