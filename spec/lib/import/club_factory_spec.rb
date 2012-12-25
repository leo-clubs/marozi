require 'spec_helper'

describe Import do
  describe Import::ClubFactory do
    subject {Import::ClubFactory.new(xml_fixture('club'), '2012-2013').build_model}

    it 'should load all simple club data correctly' do
      subject.should be_a(Club)
      subject.leo_id.should eq '200079'
      subject.year.should eq '2012-2013'
      subject.name.should eq 'Emiliaburg-Gloria'
      subject.founded_at.should eq Date.new(1972, 7, 01)
      subject.chartered_at.should eq Date.new(1973,07,07)
      subject.godfather.should eq 'LC Emiliaburg-Gloria'
      subject.meet_description.should eq '2. und 9. Donnerswoch im Febrozember 27:89 Uhr bei der Ilse'
      subject.bank.should eq 'Clubkonto: Inh.:Leo Club Emiliaburg Gloria, 0815 17/13 (KTO), 629 802 00 (BLZ)'
      subject.homepage.should eq 'www.leoclub-emiliaburg-gloria.de'
    end

    it 'should create empyt club' do
      empty_club = Import::ClubFactory.new(xml_fixture('empty_club'), '2012-2013').build_model
      empty_club.should_not be_nil
    end

    it 'should load members data correctly' do
       subject.members.should_not be_empty
       subject.members.size.should be 22
    end

    it 'should load office data correctly' do
      subject.offices.should_not be_empty
      subject.offices.size.should be 5
    end

    it 'should not mix up members of multiple clubs' do
      xml_fixture('clubs').xpath('//CLUB').each{|c| Import::ClubFactory.new(c, '2012-2013').build_model.save!}
      Club.count.should eq 2
      Member.count.should eq 22

      Club.each do |c|
        c.members.should_not be_empty
        arr = []
        c.members.map{|m| m.leo_id}.each do |m|
          arr.should_not include m
          arr << m
        end
      end
    end
  end
end