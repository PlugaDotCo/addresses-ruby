require 'spec_helper'

describe Address::Io do
  before(:each) do
    Address::Io.api_key('API_KEY')
  end

  it 'has a version number' do
    expect(Address::Io::VERSION).not_to be nil
  end

  it 'should set api_key' do
    Address::Io.api_key('API_KEY')
    expect(Address::Io.access_keys).to eq('API_KEY')
  end

  it 'should call Adressio Api' do
    url = "/v1/states"
    method = :get

    response = Address::Io::State.api_request(url, method)
    expect(response.first.class).to eq(Hash)
    expect(response.first[:code]).to eq("12")
    expect(response.class).to eq(Array)
    expect(response.size).to eq(27)
  end

  it 'should get 27 states' do
    states = Address::Io::State.list_all
    expect(states.size).to eq(27)
    expect(states.first[:code]).to be_truthy
  end

  context 'get cities' do
    it 'should return null when state is null' do
      cities = Address::Io::City.list_all
      expect(cities).to eq(nil)
    end

    it 'should get 22 cities for state AC' do
      cities = Address::Io::City.list_all state: 'ac'
      expect(cities.size).to eq(22)
    end

    it 'should get all cities for state AP' do
      cities = Address::Io::City.list_all state: 'ap'
      expect(cities.size).to eq(16)
    end
  end

  context 'get address' do
    it 'should return null when postalCode is null' do
      address = Address::Io::Addresses.retrieve
      expect(address).to eq(nil)
    end

    it 'should return error message when postalCode is not valid' do
      address = Address::Io::Addresses.retrieve "invalid"
      expect(address).to eq("The resource you are looking for has been removed, had its name changed, or is temporarily unavailable.")
    end

    it 'should return correct address when postalCode is 01311-300' do
      address = Address::Io::Addresses.retrieve "01311-300"
      expect(address).to include(
        postalCode: '01311-300',
        streetSuffix: 'Avenida',
        street: 'Paulista',
        district: 'Bela Vista',
        city: {
          code: '3550308',
          name: 'São Paulo'
        },
        state: {
          abbreviation: 'SP'
        }
      )
    end

    it 'should return correct address when postalCode is 01311300' do
      address = Address::Io::Addresses.retrieve "01311300"
      expect(address).to include(
        postalCode: '01311-300',
        streetSuffix: 'Avenida',
        street: 'Paulista',
        district: 'Bela Vista',
        city: {
          code: '3550308',
          name: 'São Paulo'
        },
        state: {
          abbreviation: 'SP'
        }
      )
    end
  end
end
