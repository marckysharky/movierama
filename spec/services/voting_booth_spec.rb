RSpec.describe VotingBooth do
  let(:haters) { double(size: 1) }
  let(:likers) { double(size: 1) }
  let(:user)   { double }
  let(:movie)  { double(haters: haters, likers: likers) }

  subject(:voting_booth) { described_class.new(user, movie) }

  describe '#vote' do
    before do
      allow(voting_booth).to receive(:unvote)
      allow(movie).to receive(:update).twice.and_return(true)
    end

    context 'like' do
      subject { voting_booth.vote(:like) }

      it do
        expect(movie.likers).to receive(:add).with(user)
        subject
      end
    end

    context 'hate' do
      subject { voting_booth.vote(:hate) }

      it do
        expect(movie.haters).to receive(:add).with(user)
        subject
      end
    end

    context 'invalid' do
      subject { voting_booth.vote(:invalid) }

      it do
        expect { subject }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#unvote' do
    subject { voting_booth.unvote }

    it do
      expect(movie.likers).to receive(:delete).with(user)
      expect(movie.haters).to receive(:delete).with(user)

      allow(movie).to receive(:update).with(liker_count: haters.size,
                                             hater_count: likers.size)
      subject
    end
  end
end
