RSpec.describe UserDecorator do
  let(:user)          { double }
  subject(:decorator) { UserDecorator.new(user) }

  describe '#wants_notifications?' do
    subject { decorator.wants_notifications? }

    before do
      allow(user).to receive(:wants_notifications) { nil }
    end

    it { is_expected.to eq(false) }

    context 'set to true' do
      before do
        allow(user).to receive(:wants_notifications) { true }
      end

      it { is_expected.to eq(true) }
    end
  end

  describe '#likes?' do
    let(:movie) { double(likers: []) }

    subject { decorator.likes?(movie) }

    it { is_expected.to eq(false) }
  end

  describe '#hates?' do
    let(:movie) { double(haters: []) }

    subject { decorator.hates?(movie) }

    it { is_expected.to eq(false) }
  end
end
