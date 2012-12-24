require 'spec_helper'

describe 'import'  do
  describe 'contact_info' do
    subject {Import::ContactInfoFactory.build_model(xml_fixture('address').element_children.first)}

    it 'should load all contact_info data correctly' do
      subject.should be_a(ContactInfo)
      subject.type.should eq :home
      subject.street.should eq 'Karl-Jaspers-Str. 86'
      subject.zip.should eq '71182'
      subject.city.should eq 'Klemensland'
      subject.country.should eq 'Germany'
    end
  end

  describe 'member' do
    subject {Import::MemberFactory.build_model(xml_fixture('member').element_children.first)}
    let(:home_contact_info) { build(:xml_home_contact_info) }

    it 'should load simple member data correctly' do
      subject.should be_a(Member)
      subject.leo_id.should eq '027146'
      subject.first_name.should eq 'Angela'
      subject.last_name.should eq 'vom Mrugalla'
      subject.gender.should eq :female
      subject.profession.should eq 'Stud. Jur.'
      subject.date_of_birth.should eq Date.new(1988, 11, 12)
      subject.member_since.should eq Date.new(2008, 7, 1)
      subject.languages.sort.should eq [:de, :en, :fr, :it]
    end

    it 'should load embedded member data correctly' do
      subject.contact_infos.should_not be_empty
      subject.contact_infos.should have_same_attributes_as([home_contact_info])
    end
  end

  describe 'club' do
    subject       {Import::ClubFactory.build_model(xml_fixture('club').element_children.first)}

    it 'should load all simple club data correctly' do
      subject.should be_a(Club)
      subject.leo_id.should eq '200079'
      subject.name.should eq 'Emiliaburg-Gloria'
      subject.founded_at.should eq Date.new(1972, 7, 01)
      subject.chartered_at.should eq Date.new(1973,07,07)
      subject.godfather.should eq 'LC Emiliaburg-Gloria'
      subject.meet_description.should eq '2. und 9. Donnerswoch im Febrozember 27:89 Uhr bei der Ilse'
      subject.bank.should eq 'Clubkonto: Inh.:Leo Club Emiliaburg Gloria, 0815 17/13 (KTO), 629 802 00 (BLZ)'
      subject.homepage.should eq 'www.leoclub-emiliaburg-gloria.de'
    end

    it 'should load members data correctly' do
       subject.should be_a(Club)
       subject.members.should_not be_empty
       subject.members.size.should be 22
    end

    it 'should not mix up members of multiple clubs' do
      xml_fixture('clubs').xpath('//CLUB').each{|c| Import::ClubFactory.build_model(c,true)}
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