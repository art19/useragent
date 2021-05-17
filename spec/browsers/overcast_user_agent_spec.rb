require 'user_agent'

shared_examples_for 'Overcast' do |version, platform, os, mobile = true|
  it "returns 'Overcast' as its browser" do
    expect(useragent.browser).to eq('Overcast')
  end

  it "returns '#{version}' as its version" do
    expect(useragent.version).to eq(version)
  end

  it "returns '#{platform}' as its platform" do
    expect(useragent.platform).to eq(platform)
  end

  it "returns '#{os}' as its operating system" do
    expect(useragent.os).to eq(os)
  end

  if mobile
    it { expect(useragent).to be_mobile }
  else
    it { expect(useragent).to be_bot }
  end
end

describe "UserAgent: Overcast/3.0 (+http://overcast.fm/; iOS podcast app) BMID/E6793162B9" do
  let!(:useragent) { UserAgent.parse("Overcast/3.0 (+http://overcast.fm/; iOS podcast app) BMID/E6793162B9") }

  it_should_behave_like 'Overcast', '3.0', 'iOS', nil
end

describe "UserAgent: Overcast (+http://overcast.fm/; Apple Watch podcast app)" do
  let!(:useragent) { UserAgent.parse("Overcast (+http://overcast.fm/; Apple Watch podcast app)") }

  it_should_behave_like 'Overcast', '', 'Apple Watch', nil
end

describe "UserAgent: Overcast/857 CFNetwork/1209 Darwin/20.3.0" do
  let!(:useragent) { UserAgent.parse("Overcast/857 CFNetwork/1209 Darwin/20.3.0") }

  it_should_behave_like 'Overcast', '857', 'iOS', 'iOS 14.4.x'
end

describe "UserAgent: Overcast/1.0 Podcast Sync (+http://overcast.fm/)" do
  let!(:useragent) { UserAgent.parse("Overcast/1.0 Podcast Sync (+http://overcast.fm/)") }

  it_should_behave_like 'Overcast', '1.0', nil, nil, false
end