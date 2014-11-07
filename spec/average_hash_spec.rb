require 'spec_helper'

describe AverageHash::Image do
  context 'fingerprint use sample_1.jpg' do
    it do
      image_1 = AverageHash::Image.new(fixture_file_path('sample_1.jpg'))
      expect(image_1.fingerprint).to eq 13158600607563222924
    end
  end

  context 'fingerprint use sample_2.jpg' do
    it do
      image_2 = AverageHash::Image.new(fixture_file_path('sample_2.jpg'))
      expect(image_2.fingerprint).to eq 7870530257777914161
    end
  end

  context 'use two jpg images' do
    before do
      @image_1 = AverageHash::Image.new(fixture_file_path('sample_1.jpg'))
      @image_2 = AverageHash::Image.new(fixture_file_path('sample_2.jpg'))
    end

    context '"sample_1" distance_from "sample_2"' do
      it { expect(@image_1.distance_from(@image_2)).to eq 36 }
    end

    context '"sample_1" duplicate? "sample_2"' do
      it { expect(@image_1.duplicate?(@image_2)).to be_falsey }
    end

    context '"sample_1" duplicate? "sample_2" with threshold 35' do
      it { expect(@image_1.duplicate?(@image_2, threshold: 35)).to be_falsey }
    end

    context '"sample_1" duplicate? "sample_2" with threshold 36' do
      it { expect(@image_1.duplicate?(@image_2, threshold: 36)).to be_truthy }
    end
  end

  context 'use duplicate jpg image, "sample_1" duplicate? "sample_1"' do
    it do
      image_1_1 = AverageHash::Image.new(fixture_file_path('sample_1.jpg'))
      image_1_2 = AverageHash::Image.new(fixture_file_path('sample_1.jpg'))
      expect(image_1_1.duplicate?(image_1_2)).to be_truthy
    end
  end
end

describe AverageHash::HashingStrategy do
  context 'generate_hash with argument "smaple_1.jpg"' do
    it do
      hashing_strategy = AverageHash::HashingStrategy.new(fixture_file_path('sample_1.jpg'))
      expect(hashing_strategy.generate_hash).to eq '1011011010011100101111011000100100001011000010111000111110001100'
    end
  end
end
