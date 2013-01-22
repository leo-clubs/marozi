require 'spec_helper'

describe Import do
  describe Import::ClubFactory do
    subject {Import::ClubFactory.new(xml_fixture('club'), '2012-2013').build_model}

    it 'should load all simple club data correctly' do
      expect(subject).to be_a(Club)
      expect(subject.leo_id).to eq 200079
      expect(subject.year).to eq '2012-2013'
      expect(subject.name).to eq 'Emiliaburg-Gloria'
      expect(subject.founded_at).to eq Date.new(1972, 7, 01)
      expect(subject.chartered_at).to eq Date.new(1973,07,07)
      expect(subject.godfather).to eq 'LC Emiliaburg-Gloria'
      expect(subject.meet_description).to eq '2. und 9. Donnerswoch im Febrozember 27:89 Uhr bei der Ilse'
      expect(subject.bank).to eq 'Clubkonto: Inh.:Leo Club Emiliaburg Gloria, 0815 17/13 (KTO), 629 802 00 (BLZ)'
      expect(subject.homepage).to eq 'www.leoclub-emiliaburg-gloria.de'
    end

    it 'should create empyt club' do
      empty_club = Import::ClubFactory.new(xml_fixture('empty_club'), '2012-2013').build_model
      expect(empty_club).to_not be_nil
    end

    it 'should load members data correctly' do
       expect(subject.members).to_not be_empty
       expect(subject.members.size).to be 22
    end

    it 'should load office data correctly' do
      expect(subject.offices).to_not be_empty
      expect(subject.offices.size).to be 5
    end

    it 'should not mix up members of multiple clubs' do
      xml_fixture('clubs').xpath('//CLUB').each{|c| Import::ClubFactory.new(c, '2012-2013').build_model.save!}
      expect(Club.count).to eq 2
      expect(Member.count).to eq 22

      Club.each do |c|
        expect(c.members).to_not be_empty
        arr = []
        c.members.map{|m| m.leo_id}.each do |m|
          expect(arr).to_not include m
          arr << m
        end
      end
    end
  end
end