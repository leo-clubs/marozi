require_relative './helper/helper'

module Import
  class OfficeImporter
    include Helper

    INITIAL_VALUE = 1000
    @@counter = INITIAL_VALUE

    def self.name_mapping
      {
        'P' => :president,
        'DSpr' => :president,
        'MDSpr' => :president,

        '1.VP' => :vice_president,
        'VDSpr' => :vice_president,
        '1.VDSpr' => :vice_president,
        'VMDSpr' => :vice_president,

        '2.VP' => :second_vice_president,
        '2.VDSpr' => :second_vice_president,

        'S' => :secretary,
        'DS' => :secretary,
        'MDS' => :secretary,

        'Sch' => :treasurer,
        'DSch' => :treasurer,
        'MDSch' => :treasurer,
        'VMDSch' => :vice_treasurer,

        'RP' => :auditor,
        'DRP' => :auditor,
        'MDRP' => :auditor,

        'PP' => :past_president,
        'IP-DSpr' => :past_president,
        'IP-MDSpr' => :past_president,

        'C' => :club_master,

        'IT' => :it_appointee,
        'DB-IT' => :it_appointee,
        'MDB-IT' => :it_appointee,

        'PR' => :pr_appointee,
        'DB-PR' => :pr_appointee,
        'MDB-PR' => :pr_appointee,

        'U' => :environment_appointee,
        'Jum' => :jumelage_appointee,
        'SUO' => :charter_appointee,

        'DB-MERLO' => :merlo_appointee,
        'MDB-MERLO' => :merlo_appointee,

        'Lion' => :lions_appointee,
        'KLeo' => :lions_appointee,

        'A' => :activity_appointee,
        'DB-Activities' => :activity_appointee,
        'MDB-Activities' => :activity_appointee,

        'HDLeo' => :hdleo_appointee,
        'MDV-P' => :mdv_president,
        'MDB MD-Seminar' => :mds_president,
        'MD-Seminar-Sch' => :mds_treasurer,

        'MDB-LeoLife' => :leolife_appointee,

        'DL LEF' => :delegation_leader_lef,
        'DL LCI-C' => :delegation_leader_lcic,
        'ILO' => :international_liaison_officer,
      }
    end

    def self.increase_counter
      @@counter += 1
    end

    def self.counter
      @@counter
    end

    def self.reset_counter
      @@counter = INITIAL_VALUE
    end

    def initialize node, year
      @node = node
      @year = year
    end

    def simple_attribute_mappings
      {
        'id' => [:leo_id, integer_lambda],
      }
    end

    def simple_element_mappings
      {
       'PERSON' => [:member_id, office_to_member_lambda],
       'NAME' => [:name, mapping_lambda(self.class.name_mapping, nil)]
      }
    end

    def build_model
      o = ::Office.new year: @year
      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: o
      extract_from_element_list list: @node.element_children, mapping: simple_element_mappings, entity: o
      o.leo_id = self.class.counter
      self.class.increase_counter
      o
    end
  end
end