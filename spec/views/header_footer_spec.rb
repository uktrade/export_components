# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'export_components/_header.html.erb', type: :view do
  before do
    allow(view).to receive(:dashboard_path).and_return('dashboard')
    allow(view).to receive(:destroy_user_session_path).and_return('signout')
    ENV['GREAT_GOV_URL'] = 'https://great.gov.uk'
    ENV['FIND_A_BUYER_URL'] = 'https://fab.gov.uk'
    ENV['SELLING_ONLINE_OVERSEAS_URL'] = 'https://soo.gov.uk'
    ENV['EVENTS_URL'] = 'https://events.gov.uk'
    ENV['SSO_ENDPOINT_BASE_URI'] = 'https://sso.gov.uk'
  end

  it 'contains the correct account links when signed in' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-profile-link')[0]['href']).to eq('dashboard')
    expect(@html.css('#header-sign-out-link')[0]['href']).to eq('signout')
  end

  it 'contains the correct account links when signed out' do
    allow(view).to receive(:current_user).and_return(false)
    ENV['SSO_ENDPOINT_BASE_URI'] = 'register'
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-register-link')[0]['href']).to eq('register/accounts/signup')
    expect(@html.css('#header-sign-in-link')[0]['href']).to eq('dashboard')
  end

  it 'contains correct export readiness links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-dit-logo')[0]['href']).to eq('https://great.gov.uk')
    expect(@html.css('#header-home-link')[0]['href']).to eq('https://great.gov.uk')
    expect(@html.css('#header-custom-page-link')[0]['href']).to eq('https://great.gov.uk/custom')
    expect(@html.css('#header-export-readiness-new')[0]['href']).to eq('https://great.gov.uk/new')
    expect(@html.css('#header-export-readiness-occasional')[0]['href']).to eq('https://great.gov.uk/occasional')
    expect(@html.css('#header-export-readiness-regular')[0]['href']).to eq('https://great.gov.uk/regular')
  end

  it 'contains correct guidance links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-guidance-market-research')[0]['href']).to eq('https://great.gov.uk/market-research')
    expect(@html.css('#header-guidance-customer-insight')[0]['href']).to eq('https://great.gov.uk/customer-insight')
    expect(@html.css('#header-guidance-finance')[0]['href']).to eq('https://great.gov.uk/finance')
    expect(@html.css('#header-guidance-business-planning')[0]['href']).to eq('https://great.gov.uk/business-planning')
    expect(@html.css('#header-guidance-getting-paid')[0]['href']).to eq('https://great.gov.uk/getting-paid')
    expect(@html.css('#header-guidance-operations-and-compliance')[0]['href']).to eq('https://great.gov.uk/operations-and-compliance')
  end

  it 'contains correct services links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#header-services-find-a-buyer')[0]['href']).to eq('https://fab.gov.uk')
    expect(@html.css('#header-services-selling-online-overseas')[0]['href']).to eq('https://soo.gov.uk')
    expect(@html.css('#header-services-export-opportunities')[0]['href']).to eq('/')
    expect(@html.css('#header-services-get-finance')[0]['href']).to eq('https://great.gov.uk/get-finance')
    expect(@html.css('#header-services-events')[0]['href']).to eq('https://events.gov.uk')
  end
end


RSpec.describe 'export_components/_footer.html.erb', type: :view do
  before do
    ENV['GREAT_GOV_URL'] = 'https://great.gov.uk'
    ENV['FIND_A_BUYER_URL'] = 'https://fab.gov.uk'
    ENV['SELLING_ONLINE_OVERSEAS_URL'] = 'https://soo.gov.uk'
    ENV['EVENTS_URL'] = 'https://events.gov.uk'
    ENV['SSO_ENDPOINT_BASE_URI'] = 'https://sso.gov.uk'
  end

  it 'contains correct export readiness links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-custom-page-link')[0]['href']).to eq('https://great.gov.uk/custom')
    expect(@html.css('#footer-export-readiness-new')[0]['href']).to eq('https://great.gov.uk/new')
    expect(@html.css('#footer-export-readiness-occasional')[0]['href']).to eq('https://great.gov.uk/occasional')
    expect(@html.css('#footer-export-readiness-regular')[0]['href']).to eq('https://great.gov.uk/regular')
  end

  it 'contains correct guidance links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-guidance-market-research')[0]['href']).to eq('https://great.gov.uk/market-research')
    expect(@html.css('#footer-guidance-customer-insight')[0]['href']).to eq('https://great.gov.uk/customer-insight')
    expect(@html.css('#footer-guidance-finance')[0]['href']).to eq('https://great.gov.uk/finance')
    expect(@html.css('#footer-guidance-business-planning')[0]['href']).to eq('https://great.gov.uk/business-planning')
    expect(@html.css('#footer-guidance-getting-paid')[0]['href']).to eq('https://great.gov.uk/getting-paid')
    expect(@html.css('#footer-guidance-operations-and-compliance')[0]['href']).to eq('https://great.gov.uk/operations-and-compliance')
  end

  it 'contains correct services links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-services-find-a-buyer')[0]['href']).to eq('https://fab.gov.uk')
    expect(@html.css('#footer-services-selling-online-overseas')[0]['href']).to eq('https://soo.gov.uk')
    expect(@html.css('#footer-services-export-opportunities')[0]['href']).to eq('/')
    expect(@html.css('#footer-services-get-finance')[0]['href']).to eq('https://great.gov.uk/get-finance')
    expect(@html.css('#footer-services-events')[0]['href']).to eq('https://events.gov.uk')
  end

  it 'contains correct site links' do
    allow(view).to receive(:current_user).and_return('user')
    render
    @html = Nokogiri::HTML(rendered)
    expect(@html.css('#footer-site-links-contact')[0]['href']).to eq('https://contact-us.export.great.gov.uk/directory/FeedbackForm')
    expect(@html.css('#footer-site-links-privacy-and-cookies')[0]['href']).to eq('https://great.gov.uk/privacy-and-cookies')
    expect(@html.css('#footer-site-links-t-and-c')[0]['href']).to eq('https://great.gov.uk/terms-and-conditions')
    expect(@html.css('#footer-site-links-performance')[0]['href']).to eq('https://great.gov.uk/performance-dashboard')
    expect(@html.css('#footer-site-links-dit')[0]['href']).to eq('https://www.gov.uk/government/organisations/department-for-international-trade')
  end
end
