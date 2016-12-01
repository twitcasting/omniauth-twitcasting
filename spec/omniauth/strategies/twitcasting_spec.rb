require 'spec_helper'

describe OmniAuth::Strategies::Twitcasting do
  subject do
    described_class.new({})
  end

  describe "production client options" do
    it { expect(subject.options.name).to eq('twitcasting') }

    it { expect(subject.options.client_options.site).to eq('https://apiv2.twitcasting.tv') }
    it { expect(subject.options.client_options.authorize_url).to eq('/oauth2/authorize') }
    it { expect(subject.options.client_options.token_url).to eq('/oauth2/access_token') }
  end

  describe "callback phase instance methods" do
    let(:uuid) { 123 }
    let(:raw_info) {
      {
        'user' => {
          'id' => uuid
        }
      }
    }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    describe "#uid" do
      it "returns user.id from the info hash" do
        expect(subject.uid).to eq(uuid)
      end
    end
  end
end
