# frozen_string_literal: true

require 'user_agent'

shared_examples 'Facebook' do |version, platform, os, type|
  it "returns 'Facebook' as its browser" do
    expect(useragent.browser).to eq('Facebook')
  end

  it "should return '#{version}' as its version" do
    expect(useragent.version).to eq(version)
  end

  it "should return '#{platform}' as its platform" do
    expect(useragent.platform).to eq(platform)
  end

  it "should return '#{os}' as its os" do
    expect(useragent.os).to eq(os)
  end

  if type == :desktop
    it { expect(useragent).to be_desktop }
    it { expect(useragent).not_to be_mobile }
  elsif type == :mobile
    it { expect(useragent).to be_mobile }
    it { expect(useragent).not_to be_desktop }
  end

  it { expect(useragent).not_to be_speaker }
  it { expect(useragent).not_to be_bot }
end

describe "UserAgent: Mozilla/5.0 (Linux; Android 5.1; XT1039 Build/LPBS23.13-17.6-1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.116 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/137.0.0.24.91;]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (Linux; Android 5.1; XT1039 Build/LPBS23.13-17.6-1; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/60.0.3112.116 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/137.0.0.24.91;]") }

  it_behaves_like 'Facebook', '137.0.0.24.91', 'Android', 'Android 5.1', :mobile
end

describe "UserAgent: Mozilla/5.0 (Linux; Android 7.0; SM-J710F Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.158 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/172.0.0.66.93;]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (Linux; Android 7.0; SM-J710F Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.158 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/172.0.0.66.93;]") }

  it_behaves_like 'Facebook', '172.0.0.66.93', 'Android', 'Android 7.0', :mobile
end

describe "UserAgent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60 [FBAN/FBIOS;FBAV/171.0.0.49.95;FBBV/107251038;FBDV/iPhone8 ,1;FBMD/iPhone;FBSN/iOS;FBSV/10.3.3;FBSS/2;FBCR/TelekomHU;FBID/phone;FBLC/hu_HU;FBOP/5;FBRV/0]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60 [FBAN/FBIOS;FBAV/171.0.0.49.95;FBBV/107251038;FBDV/iPhone8 ,1;FBMD/iPhone;FBSN/iOS;FBSV/10.3.3;FBSS/2;FBCR/TelekomHU;FBID/phone;FBLC/hu_HU;FBOP/5;FBRV/0]") }

  it_behaves_like 'Facebook', '171.0.0.49.95', 'iPhone', 'iOS 10.3.3', :mobile
end

describe "UserAgent: Mozilla/5.0 (iPad; CPU OS 11_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15F5071a [FBAN/FBIOS;FBAV/171.0.0.49.95;FBBV/107251038;FBDV/iPad7 ,3;FBMD/iPad;FBSN/iOS;FBSV/11.4;FBSS/2;FBCR/;FBID/tablet;FBLC/nl_NL;FBOP/5;FBRV/0]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (iPad; CPU OS 11_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15F5071a [FBAN/FBIOS;FBAV/171.0.0.49.95;FBBV/107251038;FBDV/iPad7 ,3;FBMD/iPad;FBSN/iOS;FBSV/11.4;FBSS/2;FBCR/;FBID/tablet;FBLC/nl_NL;FBOP/5;FBRV/0]") }

  it_behaves_like 'Facebook', '171.0.0.49.95', 'iPad', 'iOS 11.4', :mobile
end

describe "UserAgent: Mozilla/5.0 (Linux; Tizen 3.0.0.0; Samsung SM-Z400Y) AppleWebKit/537.3 (KHTML, like Gecko) Version/3.0.0.0 Mobile Safari/537.3 [FBAN/FB4T;FBAV/1.0.57;FBBV/1.0.57;FBMF/Samsung;FBDV/SM-Z400Y;FBSN/Tizen;FBSV/3.0.0.0;FBCR/655-10;FBLC/en_ZA;FBCM/{density=233 ,width=480,height=800};]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (Linux; Tizen 3.0.0.0; Samsung SM-Z400Y) AppleWebKit/537.3 (KHTML, like Gecko) Version/3.0.0.0 Mobile Safari/537.3 [FBAN/FB4T;FBAV/1.0.57;FBBV/1.0.57;FBMF/Samsung;FBDV/SM-Z400Y;FBSN/Tizen;FBSV/3.0.0.0;FBCR/655-10;FBLC/en_ZA;FBCM/{density=233 ,width=480,height=800};]") }

  it_behaves_like 'Facebook', '1.0.57', 'Linux', 'Samsung SM-Z400Y', :mobile
end

describe "UserAgent: Mozilla/5.0 (Windows NT 10.0.15063.413; osmeta 9.3.1233) AppleWebKit/602.1.1 (KHTML, like Gecko) Version/9.0 Safari/602.1.1 osmeta/9.3.1233 Build/1233 [FBAN/FBW;FBAV/93.0.0.64.0;FBBV/62624619;FBDV/WindowsDevice;FBMD/550-227c;FBSN/Windows;FBSV/10.0.15063.413;FBSS/1;FBCR/;FBID/desktop;FBLC/en_US;FBOP/45;FBRV/0]" do
  let(:useragent) { UserAgent.parse("Mozilla/5.0 (Windows NT 10.0.15063.413; osmeta 9.3.1233) AppleWebKit/602.1.1 (KHTML, like Gecko) Version/9.0 Safari/602.1.1 osmeta/9.3.1233 Build/1233 [FBAN/FBW;FBAV/93.0.0.64.0;FBBV/62624619;FBDV/WindowsDevice;FBMD/550-227c;FBSN/Windows;FBSV/10.0.15063.413;FBSS/1;FBCR/;FBID/desktop;FBLC/en_US;FBOP/45;FBRV/0]") }

  it_behaves_like 'Facebook', '93.0.0.64.0', 'Windows', 'Windows NT 10.0.15063.413', :desktop
end
