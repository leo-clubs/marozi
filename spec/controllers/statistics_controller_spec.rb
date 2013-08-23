require 'spec_helper'

describe StatisticsController do
  context 'protected methods' do
    include_context 'protected controller'

    let(:existing_id) {300066}

    describe '#gender_ratio' do
      it 'dispatches correctly to club' do
        club_mock = double('Club')
        Club.stub(:find_by!).and_return(club_mock)
        expect(club_mock).to receive(:gender_ratio).and_return('correctly stubbed')
        get :gender_ratio, id: existing_id, type: 'clubs'
        expect(response.body).to eq 'correctly stubbed'
      end

      it 'dispatches correctly to district' do
        district_mock = double('District')
        District.stub(:find_by!).and_return(district_mock)
        expect(district_mock).to receive(:gender_ratio).and_return('correctly stubbed')
        get :gender_ratio, id: existing_id, type: 'districts'
        expect(response.body).to eq 'correctly stubbed'
      end

      it 'dispatches correctly to multiple district' do
        multiple_district_mock = double('MultipleDistrict')
        MultipleDistrict.stub(:find_by!).and_return(multiple_district_mock)
        expect(multiple_district_mock).to receive(:gender_ratio).and_return('correctly stubbed')
        get :gender_ratio, id: existing_id, type: 'multiple_districts'
        expect(response.body).to eq 'correctly stubbed'
      end

      it 'returns 403 for wrong type' do
        get :gender_ratio, id: existing_id, type: 'fancy_injection'
        expect(response.status).to eq 403
      end
    end
  end
end