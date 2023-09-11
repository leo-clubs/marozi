module Import
  module Mappings
    extend self

    def offices_mappings
      {
        'P' => {
          name: :president,
          parent: Club,
        },
        'DSpr' => {
          name: :president,
          parent: District,
        },
        'MDSpr' => {
          name: :president,
          parent: MultipleDistrict,
        },
        'VP' => {
          name: :vice_president,
          parent: Club,
        },
        '1.VP' => {
          name: :vice_president,
          parent: Club,
        },
        'VDSpr' => {
          name: :vice_president,
          parent: District,
        },
        '1.VDSpr' => {
          name: :vice_president,
          parent: District,
        },
        'VMDSpr' => {
          name: :vice_president,
          parent: MultipleDistrict,
        },

        '2.VP' => {
          name: :vice_president,
          parent: Club,
        },
        '2.VDSpr' => {
          name: :vice_president,
          parent: District,
        },

       'S' => {
          name: :secretary,
          parent: Club,
        },
       'DS' => {
          name: :secretary,
          parent: District,
        },
       'MDS' => {
          name: :secretary,
          parent: MultipleDistrict,
        },

       'Sch' => {
          name: :treasurer,
          parent: Club,
        },
       'DSch' => {
          name: :treasurer,
          parent: District,
        },
       'MDSch' => {
          name: :treasurer,
          parent: MultipleDistrict,
        },
       'VMDSch' => {
          name: :vice_treasurer,
          parent: MultipleDistrict,
        },

        'RP' => {
          name: :auditor,
          parent: Club,
        },
        'DRP' => {
          name: :auditor,
          parent: District,
        },
        'RP' => {
          name: :auditor,
          parent: MultipleDistrict,
        },

        'PP' => {
          name: :past_president,
          parent: Club,
        },
        'IP-DSpr' => {
          name: :past_president,
          parent: District,
        },
        'IP-MDSpr' => {
          name: :past_president,
          parent: MultipleDistrict,
        },

        'C' => {
          name: :club_master,
          parent: Club,
        },

        'IT' => {
          name: :it_appointee,
          parent: Club,
        },
        'DB-IT' => {
          name: :it_appointee,
          parent: District,
        },
        'MDB-IT' => {
          name: :it_appointee,
          parent: MultipleDistrict,
        },

        'PR' => {
          name: :pr_appointee,
          parent: Club,
        },
        'DB-PR' => {
          name: :pr_appointee,
          parent: District,
        },
        'MDB-PR' => {
          name: :pr_appointee,
          parent: MultipleDistrict,
        },

        'U' => {
          name: :environment_appointee,
          parent: Club,
        },
        'Jum' => {
          name: :jumelage_appointee,
          parent: Club,
        },
        'SUO' => {
          name: :charter_appointee,
          parent: Club,
        },

        'DB-MERLO' => {
          name: :merlo_appointee,
          parent: District,
        },
        'MDB-MERLO' => {
          name: :merlo_appointee,
          parent: MultipleDistrict,
        },

        'Lion' => {
          name: :lions_appointee,
          parent: Club,
        },
        'KLeo' => {
          name: :lions_appointee,
          parent: District,
        },
        'KLEO' => {
          name: :lions_appointee,
          parent: District,
        },

        'A' => {
          name: :activity_appointee,
          parent: Club,
        },
        'DB-Activities' => {
          name: :activity_appointee,
          parent: District,
        },
        'MDB-Activities' => {
          name: :activity_appointee,
          parent: MultipleDistrict,
        },

        'HDLeo' => {
          name: :hdleo_appointee,
          parent: MultipleDistrict,
        },
        'MDV-P' => {
          name: :mdv_president,
          parent: MultipleDistrict,
        },
        'MDB MD-Seminar' => {
          name: :mds_president,
          parent: MultipleDistrict,
        },
        'MDB MD-Seminar' => {
          name: :mds_president,
          parent: MultipleDistrict,
        },
        'MD-Seminar-Sch' => {
          name: :mds_treasurer,
          parent: MultipleDistrict,
        },
        'MDB-LCIC' => {
          name: :lcic_appointee,
          parent: MultipleDistrict,
        },

        'MDB-LeoLife' => {
          name: :leolife_appointee,
          parent: MultipleDistrict,
        },

        'DL LEF' => {
          name: :delegation_leader_lef,
          parent: MultipleDistrict,
        },
        'DL LCI-C' => {
          name: :delegation_leader_lcic,
          parent: MultipleDistrict,
        },
        'ILO' => {
          name: :international_liaison_officer,
          parent: MultipleDistrict,
        },
      }
    end

    def expand_years year_string
      years = year_string.split('-').map{|n| n.to_i}
      range = (years[0]..years[1])
      range.each_cons(2)
    end

    def hash_by_club_id club_id, name
      value = offices_mappings[name]
      return nil if value.nil?
      type = value[:parent]
      id = what_to_do_hash[type].call(club_id.to_i)
      return nil if id.nil?

      {
        provides_offices_id: id,
        name: value[:name],
        provides_offices_type: type.to_s,
      }
    end

    def hash_by_member_id member_id, name
      value = offices_mappings[name]
      return nil if value.nil?

      type = value[:parent]
      member = Member.where(oid: member_id).first
      return nil if member.nil?
      id = what_to_do_hash[type].call(member.club.oid) 

      {
        member_id: member_id,
        provides_offices_id: id,
        name: value[:name],
        provides_offices_type: type.to_s.camelize,
      }
    end

    def what_to_do_hash
      {
        Club => proc{|id| id },
        District => proc{|id| Club.where(oid: id).first.parent.oid rescue nil},
        MultipleDistrict => proc{|id| Club.where(oid: id).first.parent.parent.oid rescue nil},
      }
    end
  end
end