RSpec.describe VoteNotifier do
  let(:user_voter)  { double }
  let(:user_author) { double }
  let(:movie)       { double(user: user_author) }
  let(:mailer)      { double }

  subject(:notifier) do
    described_class.new(user_voter, movie, mailer)
  end

  describe '#notify' do
    subject { notifier.notify(:foo) }

    context 'voter and submitter are the same' do
      before do
        allow(user_voter).to receive(:uid) { 1 }
        allow(user_author).to receive(:uid) { 1 }
      end

      it { should eq(false) }
    end

    context 'user wants notifications' do
      before do
        allow(user_voter).to receive(:uid)  { 1 }
        allow(user_author).to receive(:uid) { 2 }
        allow(user_author).to receive(:wants_notifications).and_return(true)
      end

      context 'email present' do
        before do
          allow(user_author).to receive(:email) { 'foo@bar.com' }
        end

        it do
          expect(mailer).to receive(:call)
          subject
        end
      end

      context 'email not present' do
        before do
          allow(user_author).to receive(:email)
        end

        it do
          expect(mailer).to_not receive(:call)
          subject
        end
      end
    end

    context 'user does not want notifications' do
      before do
        allow(user_voter).to receive(:uid)  { 1 }
        allow(user_author).to receive(:uid) { 2 }
        allow(user_author).to receive(:wants_notifications).and_return(false)
      end

      it do
        expect(mailer).to_not receive(:call)
        subject
      end
    end

  end
end
