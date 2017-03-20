require 'spec_helper'

describe BitmapEditor do
  # All this specs bypass BitmapEditor class encapsulation by using 'send' method

  before {
    @editor = BitmapEditor.new
  }

  subject { @editor }

  describe 'program output' do

    it 'should return goodbye' do
      expect{
        @editor.send(:parse, 'X')
      }.to output(/goodbye/).to_stdout
    end

    it 'should return help menu' do
      help_text = @editor.send(:show_help)

      expect{
        @editor.send(:parse, '?')
      }.to output(help_text).to_stdout
    end

    it 'should not recognise input' do
      expect{
        @editor.send(:parse, 'alice')
      }.to output(/unrecognised command/).to_stdout
    end

    it 'should an error: bitmap not created yet' do
      expect{
        @editor.send(:parse, 'S')
      }.to raise_error("Bitmap does not exist")
    end

    it 'should create a 999X999 bitmapt' do
      expect{
        @editor.send(:parse, 'I 999 999')
      }.to_not output.to_stdout
    end

    it 'should create a 20X20 bitmapt' do
      expect{
        @editor.send(:parse, 'I 20 20')
      }.to_not output.to_stdout
    end

    it 'should create a 5X5 bitmapt' do
      expect{
        @editor.send(:parse, 'I 5 5')
      }.to_not output.to_stdout
    end

    describe 'unrecognised commands errors' do
      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'C 2')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, '? 2')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'I 2 R')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'L 2 R')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'L 2 2 2')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'H 2 2 2 2')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'V 2 2 2 2')
        }.to output(/unrecognised command/).to_stdout
      end

      it 'should an error: unrecognised command' do
        expect{
          @editor.send(:parse, 'X 2')
        }.to output(/unrecognised command/).to_stdout
      end
    end

    describe 'errors while trying to colorize' do

      it 'should an error: bitmap not created yet' do
        expect{
          @editor.send(:parse, 'L 1 1 Y')
        }.to raise_error("Bitmap does not exist")
      end

      it 'should an error: bitmap not created yet' do
        expect{
          @editor.send(:parse, 'H 1 1 2 Y')
        }.to raise_error("Bitmap does not exist")
      end

      it 'should an error: bitmap not created yet' do
        expect{
          @editor.send(:parse, 'V 1 1 2 Y')
        }.to raise_error("Bitmap does not exist")
      end

      it 'should an error: bitmap not created yet' do
        expect{
          @editor.send(:parse, 'L 1 1 R')
        }.to raise_error("Bitmap does not exist")
      end
    end

    describe 'create and paint bitmap' do

      before {
        @editor.send(:parse, 'I 2 2')
      }

      it 'should print the bitmap' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("O O\nO O\n").to_stdout
      end

      it 'should paint the pixel (1,1)' do
        @editor.send(:parse, 'L 1 1 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R O\nO O\n").to_stdout
      end

      it 'should paint the first row' do
        @editor.send(:parse, 'H 1 2 1 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R R\nO O\n").to_stdout
      end

      it 'should paint the second row' do
        @editor.send(:parse, 'H 1 2 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("O O\nR R\n").to_stdout
      end

      it 'should paint the first column' do
        @editor.send(:parse, 'V 1 1 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R O\nR O\n").to_stdout
      end

      it 'should paint the second column' do
        @editor.send(:parse, 'V 2 1 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("O R\nO R\n").to_stdout
      end
    end

    describe 'fills a bucket on a 3X3 bitmap' do
      before {
        @editor.send(:parse, 'I 3 3')
        @editor.send(:parse, 'H 1 3 2 A')
        @editor.send(:parse, 'V 2 1 3 A')
        @editor.send(:parse, 'F 2 2 B')
      }

      it 'should paint the bucket' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("O B O\nB B B\nO B O\n").to_stdout
      end
    end

    describe 'fills a bucket on a 2X2 bitmap' do
      before {
        @editor.send(:parse, 'I 2 2')
        @editor.send(:parse, 'H 1 2 1 A')
        @editor.send(:parse, 'H 1 2 2 A')
        @editor.send(:parse, 'F 1 1 B')
      }

      it 'should paint the bucket' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("B B\nB B\n").to_stdout
      end
    end

    describe 'fills a bucket on a 5X5 bitmap' do
      before {
        @editor.send(:parse, 'I 5 5')
        @editor.send(:parse, 'H 1 5 2 A')
        @editor.send(:parse, 'H 1 5 3 A')
        @editor.send(:parse, 'F 2 2 B')
      }

      it 'should paint the bucket' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("O O O O O\nB B B B B\nB B B B B\nO O O O O\nO O O O O\n").to_stdout
      end
    end

    describe 'fills another bucket on a 5X5 bitmap' do
      before {
        @editor.send(:parse, 'I 5 5')
        @editor.send(:parse, 'H 1 5 2 A')
        @editor.send(:parse, 'H 1 5 3 A')
        @editor.send(:parse, 'L 1 2 K')
        @editor.send(:parse, 'F 2 2 B')
      }

      it 'should paint the bucket' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("O O O O O\nK B B B B\nB B B B B\nO O O O O\nO O O O O\n").to_stdout
      end
    end

    describe 'fills another bucket on a 10X10 bitmap' do
      before {
        @editor.send(:parse, 'I 10 10')
        @editor.send(:parse, 'H 1 10 1 K')
        @editor.send(:parse, 'F 10 10 H')
      }

      it 'should paint the bucket' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("K K K K K K K K K K\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\nH H H H H H H H H H\n").to_stdout
      end
    end

    describe 'cleaning the bitmap' do
      before {
        @editor.send(:parse, 'I 2 2')
        @editor.send(:parse, 'L 1 1 R')
      }

      it 'should have the (1,1) pixel painted' do
        expect{
          @editor.send(:parse, 'S')
        }.to output("R O\nO O\n").to_stdout
      end

      it 'should clean the bitmap' do
        @editor.send(:parse, 'C')
        expect{
          @editor.send(:parse, 'S')
        }.to output("O O\nO O\n").to_stdout
      end
    end
  end
end
