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
