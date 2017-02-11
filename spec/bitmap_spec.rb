require 'spec_helper'

describe Bitmap do
  before { 
    @bitmap = Bitmap.new(5,5)
  }

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

    it 'should paint the (2,3) pixel with red' do
      c = 'R'
      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, c, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end

    it 'should paint the (5,5) pixel with red' do
      c = 'R'
      subject.paint_pixel(5, 5, c)

      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, c, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, c]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end
  end

  describe 'paint a horizontal line' do
    before do
      subject.paint_row(2, 1, 5, 'R')
    end

    it 'should paint the second row with red' do
      c = 'R'
      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [c, c, c, c, c],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end
  end

  describe 'paint a vertical line' do
    before do
      subject.paint_column(2, 1, 5, 'Y')
    end

    it 'should paint the second column with yellow' do
      c = 'Y'
      expected_bitmap = [
        [0, c, 0, 0, 0],
        [0, c, 0, 0, 0],
        [0, c, 0, 0, 0],
        [0, c, 0, 0, 0],
        [0, c, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end
  end

  describe 'bitmap clear' do
    it 'should clear the bitmap' do
      subject.clear_image

      expected_bitmap = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(subject.print).to eq(expected_bitmap)
    end
  end
end
