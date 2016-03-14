require 'rails_helper'
RSpec.describe User do
  it 'requires a name' do
    user = User.new(first_name: '')
    user.valid?
    expect(user.errors[:first_name].any?).to eq(true)
  end
  it 'requires a last name' do
    user = User.new(last_name: '')
    user.valid?
    expect(user.errors[:last_name].any?).to eq(true)
  end
  it 'requires an email' do
    user = User.new(email: '')
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end
  it 'accepts properly formatted email' do
    emails = ['kobe@lakers.com', 'kobe.bryant@lakers.com']
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end
  it 'rejects improperly formatted email' do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end
  it 'requires a unique, case insensitive email address' do
    user1 = User.create(first_name:'kobe', last_name:'bryant', email: 'kobe@lakers.com', password: 'password', password_confirmation: 'password')
    user2 = User.new(email: user1.email.upcase)
    user2.valid?
    expect(user2.errors[:email].first).to eq("has already been taken")
  end
  it 'requires a password' do
    user = User.new(password: '')
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end
  it 'requires the password to match the password confirmation' do
    user = User.new(password: 'password', password_confirmation: 'not password')
    user.valid?
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end
  it 'automatically encrypts the password into the password_digest attribute' do
    user = User.create(first_name:'kobe', email: 'kobe@lakers.com', password: 'password', password_confirmation: 'password')
    expect(user.encrypted_password.present?).to eq(true)
  end
  it 'accepts jpg files' do 
    pin = User.new(image_content_type: 'image/jpg')
    pin.valid?
    expect(pin.errors[:image_content_type].first).to eq(nil)
  end
  it 'accepts jpeg files' do 
    pin = User.new(image_content_type: 'image/jpeg')
    pin.valid?
    expect(pin.errors[:image_content_type].first).to eq(nil)
  end
  it 'accepts png files' do 
    pin = User.new(image_content_type: 'image/png')
    pin.valid?
    expect(pin.errors[:image_content_type].first).to eq(nil)
  end
  it 'accepts gif files' do 
    pin = User.new(image_content_type: 'image/gif')
    pin.valid?
    expect(pin.errors[:image_content_type].first).to eq(nil)
  end
  it 'does not accept pdf files' do 
    pin = User.new(image_content_type: 'image/pdf')
    pin.valid?
    expect(pin.errors[:image_content_type].first).to eq('is invalid')
  end
end