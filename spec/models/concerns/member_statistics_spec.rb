require 'spec_helper'

describe MemberStatistics do
  describe '#gender_ratio' do
    let(:active_members_only) do
      members = []
      {
        female: 11,
        male: 12,
      }.each do |gender, num|
        num.times do
          member = double('Member')
          member.stub(:gender){ gender }
          member.stub(:status){ :active }
          members << member
        end
      end

      o = double()
      o.stub(:members) { members }
      o.extend(described_class)
    end

    let(:active_inactive_members) do
      members = []
      [
        {
          status: :active,
          gender: :female,
          num: 5,
        },
        {
          status: :passive,
          gender: :female,
          num: 9,
        },
        {
          status: :active,
          gender: :male,
          num: 3,
        },
        {
          status: :passive,
          gender: :male,
          num: 16,
        }
      ].each do |hash|
        hash[:num].times do
          member = double('Member')
          member.stub(:gender){ hash[:gender] }
          member.stub(:status){ hash[:status] }
          members << member
        end
      end

      o = double()
      o.stub(:members) { members }
      o.extend(described_class)
    end

    it 'returns correct ratio for active only members' do
      expected_result = {
        female: 11,
        male: 12,
      }
      expect(active_members_only.gender_ratio(:active)).to eq(expected_result)
    end

    it 'returns correct ratio for mixed members active' do
      expected_result = {
        female: 5,
        male: 3,
      }
      expect(active_inactive_members.gender_ratio(:active)).to eq(expected_result)
    end

    it 'returns correct ratio for mixed members active' do
      expected_result = {
        female: 9,
        male: 16,
      }
      expect(active_inactive_members.gender_ratio(:passive)).to eq(expected_result)
    end
  end
end