require 'rails_helper'
RSpec.describe Pin do 
	it 'requires a description' do
		pin = Pin.new(description: '')
		pin.valid?
		expect(pin.errors[:description].any?).to eq(true)
	end
	it 'has attached file name' do
		pin = Pin.new(image_file_name: '', image_content_type: '', image_file_size: '')
		pin.valid?
		expect(pin.errors.count).to eq(4)
	end
	it 'accepts jpg files' do 
		pin = Pin.new(image_content_type: 'image/jpg')
		pin.valid?
		expect(pin.errors[:image_content_type].first).to eq(nil)
	end
	it 'accepts jpeg files' do 
		pin = Pin.new(image_content_type: 'image/jpeg')
		pin.valid?
		expect(pin.errors[:image_content_type].first).to eq(nil)
	end
	it 'accepts png files' do 
		pin = Pin.new(image_content_type: 'image/png')
		pin.valid?
		expect(pin.errors[:image_content_type].first).to eq(nil)
	end
	it 'accepts gif files' do 
		pin = Pin.new(image_content_type: 'image/gif')
		pin.valid?
		expect(pin.errors[:image_content_type].first).to eq(nil)
	end
	it 'does not accept pdf files' do 
		pin = Pin.new(image_content_type: 'image/pdf')
		pin.valid?
		expect(pin.errors[:image_content_type].first).to eq('is invalid')
	end
end