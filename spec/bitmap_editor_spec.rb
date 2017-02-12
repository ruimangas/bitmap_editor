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
        }.to output("0 0\n0 0\n").to_stdout
      end

      it 'should paint the pixel (1,1)' do
        @editor.send(:parse, 'L 1 1 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R 0\n0 0\n").to_stdout
      end

      it 'should paint the first row' do
        @editor.send(:parse, 'H 1 2 1 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R R\n0 0\n").to_stdout
      end

      it 'should paint the second row' do
        @editor.send(:parse, 'H 1 2 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("0 0\nR R\n").to_stdout
      end

      it 'should paint the first column' do
        @editor.send(:parse, 'V 1 1 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("R 0\nR 0\n").to_stdout
      end

      it 'should paint the second column' do
        @editor.send(:parse, 'V 2 1 2 R')

        expect{
          @editor.send(:parse, 'S')
        }.to output("0 R\n0 R\n").to_stdout
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
        }.to output("R 0\n0 0\n").to_stdout
      end

      it 'should clean the bitmap' do
        @editor.send(:parse, 'C')
        expect{
          @editor.send(:parse, 'S')
        }.to output("0 0\n0 0\n").to_stdout
      end
    end
  end
end
