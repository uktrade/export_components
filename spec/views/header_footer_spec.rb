# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_header.html.erb', type: :view do
  before do
    allow(view).to receive(:dashboard_path).and_return('dashboard')
    allow(view).to receive(:destroy_user_session_path).and_return('signout')
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :GREAT_GOV_URL).and_return('https://great.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :FIND_A_BUYER_URL).and_return('https://fab.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :SELLING_ONLINE_OVERSEAS_URL).and_return('https://soo.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :EVENTS_URL).and_return('https://events.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :SSO_ENDPOINT_BASE_URI).and_return('https://sso.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :FEATURES_EXPORT_JOURNEY_DISABLED).and_return(false)
  end

  it 'contains the correct account links when signed in' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-profile-link').first['href']).to eq('dashboard')
    expect(@html.css('#header-sign-out-link').first['href']).to eq('signout')
  end

  it 'contains the correct account links when signed out' do
    allow(view).to receive(:current_user).and_return(false)
    allow(Figaro).to receive_message_chain(:env, :SSO_ENDPOINT_BASE_URI).and_return('register')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-register-link').first['href']).to eq('register/accounts/signup')
    expect(@html.css('#header-sign-in-link').first['href']).to eq('dashboard')
  end

  it 'contains correct export readiness links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-dit-logo').first['href']).to eq('https://great.gov.uk')
    expect(@html.css('#header-home-link').first['href']).to eq('https://great.gov.uk')
    expect(@html.css('#header-custom-page-link').first['href']).to eq('https://great.gov.uk/custom')
    expect(@html.css('#header-export-readiness-new').first['href']).to eq('https://great.gov.uk/new')
    expect(@html.css('#header-export-readiness-occasional').first['href']).to eq('https://great.gov.uk/occasional')
    expect(@html.css('#header-export-readiness-regular').first['href']).to eq('https://great.gov.uk/regular')
  end

  it 'does not contain export readiness links when export journey is disabled' do
    allow(view).to receive(:current_user).and_return('user')
    allow(Figaro).to receive_message_chain(:env, :FEATURES_EXPORT_JOURNEY_DISABLED).and_return(true)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-custom-page-link').first).to be_falsey
    expect(@html.css('#header-export-readiness-new').first).to be_falsey
    expect(@html.css('#header-export-readiness-occasional').first).to be_falsey
    expect(@html.css('#header-export-readiness-regular').first).to be_falsey
  end

  it 'contains correct guidance links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-guidance-market-research').first['href']).to eq('https://great.gov.uk/market-research')
    expect(@html.css('#header-guidance-customer-insight').first['href']).to eq('https://great.gov.uk/customer-insight')
    expect(@html.css('#header-guidance-finance').first['href']).to eq('https://great.gov.uk/finance')
    expect(@html.css('#header-guidance-business-planning').first['href']).to eq('https://great.gov.uk/business-planning')
    expect(@html.css('#header-guidance-getting-paid').first['href']).to eq('https://great.gov.uk/getting-paid')
    expect(@html.css('#header-guidance-operations-and-compliance').first['href']).to eq('https://great.gov.uk/operations-and-compliance')
  end

  it 'contains correct services links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-services-find-a-buyer').first['href']).to eq('https://fab.gov.uk')
    expect(@html.css('#header-services-selling-online-overseas').first['href']).to eq('https://soo.gov.uk')
    expect(@html.css('#header-services-export-opportunities').first['href']).to eq('/')
    expect(@html.css('#header-services-get-finance').first['href']).to eq('https://great.gov.uk/get-finance')
    expect(@html.css('#header-services-events').first['href']).to eq('https://events.gov.uk')
  end

  it 'contains the events link which opens in a new tab' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-services-events').first['rel']).to eq('noopener noreferrer')
    expect(@html.css('#header-services-events').first['target']).to eq('_blank')
  end
end

RSpec.describe 'export_components/_footer.html.erb', type: :view do
  before do
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :GREAT_GOV_URL).and_return('https://great.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :FIND_A_BUYER_URL).and_return('https://fab.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :SELLING_ONLINE_OVERSEAS_URL).and_return('https://soo.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :EVENTS_URL).and_return('https://events.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :SSO_ENDPOINT_BASE_URI).and_return('https://sso.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :FEATURES_EXPORT_JOURNEY_DISABLED).and_return(false)
  end

  it 'contains correct export readiness links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-custom-page-link').first['href']).to eq('https://great.gov.uk/custom')
    expect(@html.css('#footer-export-readiness-new').first['href']).to eq('https://great.gov.uk/new')
    expect(@html.css('#footer-export-readiness-occasional').first['href']).to eq('https://great.gov.uk/occasional')
    expect(@html.css('#footer-export-readiness-regular').first['href']).to eq('https://great.gov.uk/regular')
  end

  it 'does not contain export readiness links when export journey is disabled' do
    allow(view).to receive(:current_user).and_return('user')
    allow(Figaro).to receive_message_chain(:env, :FEATURES_EXPORT_JOURNEY_DISABLED).and_return(true)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-export-readiness-new').first).to be_falsey
    expect(@html.css('#footer-export-readiness-occasional').first).to be_falsey
    expect(@html.css('#footer-export-readiness-regular').first).to be_falsey
  end

  it 'contains correct guidance links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-guidance-market-research').first['href']).to eq('https://great.gov.uk/market-research')
    expect(@html.css('#footer-guidance-customer-insight').first['href']).to eq('https://great.gov.uk/customer-insight')
    expect(@html.css('#footer-guidance-finance').first['href']).to eq('https://great.gov.uk/finance')
    expect(@html.css('#footer-guidance-business-planning').first['href']).to eq('https://great.gov.uk/business-planning')
    expect(@html.css('#footer-guidance-getting-paid').first['href']).to eq('https://great.gov.uk/getting-paid')
    expect(@html.css('#footer-guidance-operations-and-compliance').first['href']).to eq('https://great.gov.uk/operations-and-compliance')
  end

  it 'contains correct services links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-services-find-a-buyer').first['href']).to eq('https://fab.gov.uk')
    expect(@html.css('#footer-services-selling-online-overseas').first['href']).to eq('https://soo.gov.uk')
    expect(@html.css('#footer-services-export-opportunities').first['href']).to eq('/')
    expect(@html.css('#footer-services-get-finance').first['href']).to eq('https://great.gov.uk/get-finance')
    expect(@html.css('#footer-services-events').first['href']).to eq('https://events.gov.uk')
  end

  it 'contains correct site links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-site-links-contact').first['href']).to eq('https://contact-us.export.great.gov.uk/directory/FeedbackForm')
    expect(@html.css('#footer-site-links-privacy-and-cookies').first['href']).to eq('https://great.gov.uk/privacy-and-cookies')
    expect(@html.css('#footer-site-links-t-and-c').first['href']).to eq('https://great.gov.uk/terms-and-conditions')
    expect(@html.css('#footer-site-links-performance').first['href']).to eq('https://great.gov.uk/performance-dashboard')
    expect(@html.css('#footer-site-links-dit').first['href']).to eq(
      'https://www.gov.uk/government/organisations/department-for-international-trade'
    )
  end
end
