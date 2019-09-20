# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_header.html.erb', type: :view do
  before do
    allow(view).to receive(:current_user).and_return('user')
    allow(view).to receive(:dashboard_path).and_return('dashboard')
    allow(view).to receive(:destroy_user_session_path).and_return('signout')
    stub_const('Figaro', double)
    allow(Figaro).to receive_message_chain(:env, :GREAT_GOV_URL).and_return('https://great.gov.uk')
    allow(Figaro).to receive_message_chain(:env, :NEWS_SECTION_ON).and_return(false)
    allow(Figaro).to receive_message_chain(:env, :HEADER_SEARCH_ON).and_return(false)
  end

  it 'contains the search box when feature is on' do
    allow(Figaro).to receive_message_chain(:env, :HEADER_SEARCH_ON).and_return(true)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#search-box').first).to be_truthy
  end

  it 'does not contain the search box when feature is off' do
    allow(Figaro).to receive_message_chain(:env, :HEADER_SEARCH_ON).and_return(false)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#search-box').first).to be_falsey
  end

  it 'contains the correct account links when signed in' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-profile-link').first['href']).to eq('dashboard')
    expect(@html.css('#header-sign-out-link').first['href']).to eq('signout')
  end

  it 'contains the correct account links when signed out' do
    allow(view).to receive(:current_user).and_return(false)
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-sign-in-link').first['href']).to eq('dashboard')
  end

  it 'contains home links' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#great-global-header-domestic-link').first['href']).to eq('https://great.gov.uk')
    expect(@html.css('#great-header-logo').first['href']).to eq('https://great.gov.uk')
  end

  it 'does not contain export readiness links' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-custom-page-link').first).to be_falsey
    expect(@html.css('#header-export-readiness-new').first).to be_falsey
    expect(@html.css('#header-export-readiness-occasional').first).to be_falsey
    expect(@html.css('#header-export-readiness-regular').first).to be_falsey
  end

  it 'does not contain old guidance links' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-guidance-market-research').first).to be_falsey
    expect(@html.css('#header-guidance-customer-insight').first).to be_falsey
    expect(@html.css('#header-guidance-finance').first).to be_falsey
    expect(@html.css('#header-guidance-business-planning').first).to be_falsey
    expect(@html.css('#header-guidance-getting-paid').first).to be_falsey
    expect(@html.css('#header-guidance-operations-and-compliance').first).to be_falsey
  end

  it 'does not contain advice subsection links' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-advice-create-an-export-plan').first).to be_falsey
    expect(@html.css('#header-advice-find-an-export-market').first).to be_falsey
    expect(@html.css('#header-advice-define-route-to-market').first).to be_falsey
    expect(@html.css('#header-advice-get-export-finance-and-funding').first).to be_falsey
    expect(@html.css('#header-advice-manage-payment-for-export-orders').first).to be_falsey
    expect(@html.css('#header-advice-prepare-to-do-business-in-a-foreign-country').first).to be_falsey
    expect(@html.css('#header-advice-manage-legal-and-ethical-compliance').first).to be_falsey
    expect(@html.css('#header-advice-prepare-for-export-procedures-and-logistics').first).to be_falsey
  end

  it 'contains advice landing page link' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-advice').first['href']).to eq('https://great.gov.uk/advice/')
  end

  it 'contains services landing page link' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-services').first['href']).to eq('https://great.gov.uk/services/')
  end

  it 'does not contain services links' do
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-services-find-a-buyer').first).to be_falsey
    expect(@html.css('#header-services-selling-online-overseas').first).to be_falsey
    expect(@html.css('#header-services-export-opportunities').first).to be_falsey
    expect(@html.css('#header-services-get-finance').first).to be_falsey
    expect(@html.css('#header-services-events').first).to be_falsey
  end

    it 'contains news link when feature flag is on' do
      allow(Figaro).to receive_message_chain(:env, :NEWS_SECTION_ON).and_return(false)
      render
      @html = Nokogiri::HTML(rendered)
      expect(@html.css('#header-services').first['href']).to eq('https://great.gov.uk/services/')
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
    allow(Figaro).to receive_message_chain(:env, :FEATURE_EXPORT_JOURNEY_DISABLED).and_return(false)
  end

  it 'does not contain export readiness links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-custom-page-link').first).to be_falsey
    expect(@html.css('#footer-export-readiness-new').first).to be_falsey
    expect(@html.css('#footer-export-readiness-occasional').first).to be_falsey
    expect(@html.css('#footer-export-readiness-regular').first).to be_falsey
  end

  it 'does not contain old guidance links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-guidance-market-research').first).to be_falsey
    expect(@html.css('#footer-guidance-customer-insight').first).to be_falsey
    expect(@html.css('#footer-guidance-finance').first).to be_falsey
    expect(@html.css('#footer-guidance-business-planning').first).to be_falsey
    expect(@html.css('#footer-guidance-getting-paid').first).to be_falsey
    expect(@html.css('#footer-guidance-operations-and-compliance').first).to be_falsey
  end

  it 'does not contain advice subsection links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-advice-create-an-export-plan').first).to be_falsey
    expect(@html.css('#footer-advice-find-an-export-market').first).to be_falsey
    expect(@html.css('#footer-advice-define-route-to-market').first).to be_falsey
    expect(@html.css('#footer-advice-get-export-finance-and-funding').first).to be_falsey
    expect(@html.css('#footer-advice-manage-payment-for-export-orders').first).to be_falsey
    expect(@html.css('#footer-advice-prepare-to-do-business-in-a-foreign-country').first).to be_falsey
    expect(@html.css('#footer-advice-manage-legal-and-ethical-compliance').first).to be_falsey
    expect(@html.css('#footer-advice-prepare-for-export-procedures-and-logistics').first).to be_falsey
  end

  it 'does not contain services links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-services-find-a-buyer').first).to be_falsey
    expect(@html.css('#footer-services-selling-online-overseas').first).to be_falsey
    expect(@html.css('#footer-services-export-opportunities').first).to be_falsey
    expect(@html.css('#footer-services-get-finance').first).to be_falsey
    expect(@html.css('#footer-services-events').first).to be_falsey
  end

  it 'contains correct site links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-site-links-about').first).to be_falsey
    expect(@html.css('#footer-contact').first['href']).to eq('https://great.gov.uk/contact/triage/location/')
    expect(@html.css('#footer-privacy-and-cookies').first['href']).to eq('https://great.gov.uk/privacy-and-cookies/')
    expect(@html.css('#footer-terms-and-conditions').first['href']).to eq('https://great.gov.uk/terms-and-conditions/')
    expect(@html.css('#footer-performance').first['href']).to eq('https://great.gov.uk/performance-dashboard/')
    expect(@html.css('#footer-dit').first['href']).to eq('https://www.gov.uk/government/organisations/department-for-international-trade/')
    expect(@html.css('#footer-accessibility').first['href']).to eq('https://www.gov.uk/accessibility-statement/')
  end

  it 'contains DIT external link to gov.uk' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-dit').first['title']).to eq('Opens in a new window')
    expect(@html.css('#footer-dit').first['target']).to eq('_blank')
    expect(@html.css('#footer-dit').first['rel']).to eq('noopener noreferrer')
  end
end
