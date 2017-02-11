require 'spec_helper'

describe Bitmap do
  before { @bitmap = Bitmap.new(5,5) }

  subject { @bitmap }

  describe 'bitmap creating' do
    it 'should return a 5X5 bitmap' do
      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end

    it 'should return a 2X3 bitmap' do
      bitmap = Bitmap.new(2,3)

      expected_bitmap = [
        [0, 0],
        [0, 0],
        [0, 0]
      ]

      expect(bitmap.print).to eq(expected_bitmap)
    end
  end

  describe 'colorization of a pixel' do
    before do
      subject.paint_pixel(2, 3, 'R')
    end

    it 'should paint the (2,3) pixel' do
      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 'R', 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end

    it 'should paint the (5,5) pixel' do
      subject.paint_pixel(5, 5, 'R')

      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 'R', 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 'R']
      ]

      expect(subject.print).to eq(expected_bitmap)
    end
  end
end
