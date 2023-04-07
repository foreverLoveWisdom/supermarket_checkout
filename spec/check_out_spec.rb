# frozen_string_literal: true

require_relative '../check_out'

describe CheckOut do
  let(:check_out) { described_class.new }
  describe '#scan' do
    context 'scans an item' do
      before do
        check_out.scan('A')
      end

      it 'returns the total price' do
        expect(check_out.total).to eq(50)
      end
    end

    context 'scans multiple items' do
      before do
        check_out.scan('A')
        check_out.scan('B')
      end

      it 'returns the total price' do
        expect(check_out.total).to eq(80)
      end
    end

    context 'scans same item multiple times with special pricing' do
      before do
        check_out.scan('A')
        check_out.scan('A')
        check_out.scan('A')
      end

      it 'returns the total price' do
        expect(check_out.total).to eq(130)
      end
    end

    context 'scans multiple different items with special pricing' do
      before do
        check_out.scan('A')
        check_out.scan('A')
        check_out.scan('A')
        check_out.scan('B')
        check_out.scan('B')
      end

      it 'returns the total price' do
        expect(check_out.total).to eq(175)
      end
    end

    context 'when scanning an item with no pricing rule' do
      before { check_out.scan('E') }

      it 'does not update total price' do
        expect(check_out.total).to eq(0)
      end
    end
  end
end
