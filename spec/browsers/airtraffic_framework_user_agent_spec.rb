# frozen_string_literal: true

require 'user_agent'

describe UserAgent::Browsers::AirTrafficFramework do
  let(:user_agent) { UserAgent.parse(ua_string) }

  shared_examples 'an ATC browser' do |version = nil|
    it { expect(user_agent.browser).to eql 'atc' }
    it { expect(user_agent).not_to be_bot }

    if version
      it { expect(user_agent.version.to_s).to eql version }
    else
      it { expect(user_agent.version).to be_nil }
    end
  end

  shared_examples 'a browser on unknown OS' do
    it { expect(user_agent.os).to be_nil}
  end

  shared_examples 'a browser on Apple Watch / watchOS' do |os_version|
    it { expect(user_agent.os).to eql ['watchOS', os_version].compact.join(' ') }
    it { expect(user_agent.platform).to eql 'Apple Watch' }
    it { expect(user_agent).to be_mobile }
  end

  shared_examples 'a browser on Macintosh / macOS' do |os_version|
    it { expect(user_agent.os).to eq ['macOS', os_version].compact.join(' ') }
    it { expect(user_agent.platform).to eql 'Macintosh' }
    it { expect(user_agent).not_to be_mobile }
  end

  shared_examples 'a browser on an iOS device' do |os_version|
    it { expect(user_agent.os).to eq ['iOS', os_version].compact.join(' ') }
    it { expect(user_agent.platform).to eql 'iOS' }
    it { expect(user_agent).to be_mobile }
  end

  context 'with "(null)/(null) watchOS/5.0 model/Watch2 ,7 hwp/t8002 build/16R349 (6; dt:149)"' do
    let(:ua_string) { '(null)/(null) watchOS/5.0 model/Watch2 ,7 hwp/t8002 build/16R349 (6; dt:149)' }

    it_behaves_like 'an ATC browser', nil
    it_behaves_like 'a browser on Apple Watch / watchOS', '5.0'
  end

  context 'with "(null)/(null) model/Watch2"' do
    let(:ua_string) { '(null)/(null) model/Watch2' }

    it { expect(user_agent.browser).to eql '(null)' }
    it { expect(user_agent).not_to be_bot }
    it { expect(user_agent).not_to be_mobile }
    it { expect(user_agent.os).to be_nil }
    it { expect(user_agent.platform).to be_nil }
    it { expect(user_agent.version.to_s).to eql '(null)' }
  end

  context 'with "atc/1.0 watchOS/5.0 model/Watch3 ,1 hwp/t8004 build/16R120 (6; dt:153)"' do
    let(:ua_string) { 'atc/1.0 watchOS/4.2 model/Watch3 ,1 hwp/t8004 build/16R120 (6; dt:153)' }

    it_behaves_like 'an ATC browser', '1.0.16R120'
    it_behaves_like 'a browser on Apple Watch / watchOS', '4.2'
  end

  context 'with "atc/1.0 watchOS model/Watch3 ,1 hwp/t8004 build/17R90 (6; dt:153)"' do
    let(:ua_string) { 'atc/1.0 watchOS model/Watch3 ,1 hwp/t8004 build/17R90 (6; dt:153)' }

    it_behaves_like 'an ATC browser', '1.0.17R90'
    it_behaves_like 'a browser on Apple Watch / watchOS', nil
  end

  context 'with "atc/1.0 watchOS/6.0 model/Watch3 ,1 hwp/t8004"' do
    let(:ua_string) { 'atc/1.0 watchOS/6.0 model/Watch3 ,1 hwp/t8004' }

    it_behaves_like 'an ATC browser', '1.0'
    it_behaves_like 'a browser on Apple Watch / watchOS', '6.0'
  end

  context 'with "atc watchOS"' do
    let(:ua_string) { 'atc watchOS' }

    it_behaves_like 'an ATC browser', nil
    it_behaves_like 'a browser on Apple Watch / watchOS', nil
  end

  context 'with "atc watchOS build/19R150"' do
    let(:ua_string) { 'atc watchOS build/19R150' }

    it_behaves_like 'an ATC browser', '.19R150'
    it_behaves_like 'a browser on Apple Watch / watchOS', nil
  end

  context 'with "atc/"' do
    let(:ua_string) { 'atc/' }

    it_behaves_like 'an ATC browser', nil
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/1.0"' do
    let(:ua_string) { 'atc/1.0' }

    it_behaves_like 'an ATC browser', '1.0'
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/1.1"' do
    let(:ua_string) { 'atc/1.1' }

    it_behaves_like 'an ATC browser', '1.1'
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/2.0"' do
    let(:ua_string) { 'atc/2.0' }

    it_behaves_like 'an ATC browser', '2.0'
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/1.0 model/Watch3 hwp/t8004 build/17R50 (6; dt:154)"' do
    let(:ua_string) { 'atc/1.0 model/Watch3 hwp/t8004 build/17R50 (6; dt:154)' }

    it_behaves_like 'an ATC browser', '1.0.17R50'
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/1.1 Darwin/19.0.0 (x86_64)"' do
    let(:ua_string) { 'atc/1.1 Darwin/19.0.0 (x86_64)' }

    it_behaves_like 'an ATC browser', '1.1'
    it_behaves_like 'a browser on Macintosh / macOS', '10.15'
  end

  context 'with "atc/1.1 Darwin (x86_64)"' do
    let(:ua_string) { 'atc/1.1 Darwin (x86_64)' }

    it_behaves_like 'an ATC browser', '1.1'
    it_behaves_like 'a browser on Macintosh / macOS', nil
  end

  context 'with "atc Darwin (x86_64)"' do
    let(:ua_string) { 'atc Darwin (x86_64)' }

    it_behaves_like 'an ATC browser', nil
    it_behaves_like 'a browser on Macintosh / macOS', nil
  end

  context 'with "atc/ build/17R50 Darwin/21.5.0 (x86_64)"' do
    let(:ua_string) { 'atc/ build/17R50 Darwin/21.5.0 (x86_64)' }

    it_behaves_like 'an ATC browser', '.17R50'
    it_behaves_like 'a browser on Macintosh / macOS', '12.4'
  end

  context 'with "Darwin/21.5.0 (x86_64)"' do
    let(:ua_string) { "Darwin/21.5.0 (x86_64)" }

    it { expect(user_agent.browser).not_to eql 'AirTraffic.framework' }
  end

  context 'with "atc/2.0 AppleTV/4.1"' do
    let(:ua_string) { 'atc/2.0 AppleTV/4.1' }

    it_behaves_like 'an ATC browser', '2.0'
    it_behaves_like 'a browser on unknown OS'
  end

  context 'with "atc/1.0 Darwin/22.0.0' do
    let(:ua_string) { "atc/1.0 Darwin/22.0.0" }

    it_behaves_like 'an ATC browser', '1.0'
    it_behaves_like 'a browser on an iOS device', '16.0.x'
  end

  context 'with "atc Darwin"' do
    let(:ua_string) { "atc Darwin" }

    it_behaves_like 'an ATC browser', nil
    it_behaves_like 'a browser on an iOS device', nil
  end

  context 'with "Darwin"' do
    let(:ua_string) { "Darwin" }

    it { expect(user_agent.browser).not_to eql 'AirTraffic.framework' }
  end
end
