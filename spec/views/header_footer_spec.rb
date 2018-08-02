# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_header.html.erb', type: :view do
  before do
    allow(view).to receive(:current_user).and_return('test')
    allow(view).to receive(:dashboard_path).and_return('test')
    allow(view).to receive(:destroy_user_session_path).and_return('test')
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(
      :env, :GREAT_GOV_URL
    ).and_return('https://great.gov.uk/')
    allow(Figaro).to receive_message_chain(
      :env, :FIND_A_BUYER_URL
    ).and_return('https://find-a-buyer.export.great.gov.uk')
    allow(Figaro).to receive_message_chain(
      :env, :SELLING_ONLINE_OVERSEAS_URL
    ).and_return('https://selling-online-overseas.export.great.gov.uk')
    allow(Figaro).to receive_message_chain(
      :env, :EVENTS_URL
    ).and_return('https://events.trade.gov.uk')
  end

  it 'renders _header partial' do
    render
    expect(rendered).to include 'foo'
  end
end
