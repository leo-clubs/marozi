module OfficeCreator
  extend self

  def create_offices_for_members doc, current_year
    doc.xpath('//MEMBER').each do |member_node|
      member_id = member_node['id'].to_i
      member_node.xpath('./FUNCTIONS').each do |functions_node|
        functions_node.element_children.each do |function_node|
          office_name = function_node.xpath('./NAME').text
          office_year = function_node.xpath('./YEAR').text
          Import::Mappings.expand_years(office_year).each do |years|
            provides_offices_id = function_node.xpath('./FCLUB').first['id']
            base_values = Import::Mappings
                  .hash_by_club_id(provides_offices_id, office_name)
            if base_values
              xml_year = years.join('-')
              values = base_values.merge(
                  year: years.join('-'),
                  current: (xml_year == current_year),
                  member_id: member_id,
                )
              create_office values
            end
          end
        end
      end
    end
  end

  def create_offices_for_appointees doc, current_year
    doc.xpath("//OFFICER[@group='Beauftragte']").each do |appointee_node|
      office_name = appointee_node.xpath('./NAME').text
      member_id = appointee_node.xpath('./PERSON/@id').text.to_i
      base_values = Import::Mappings
                        .hash_by_member_id(member_id, office_name)
      if base_values
        create_office(base_values.merge({
          year: current_year,
          current: true,
        }))
      end
    end
  end

  def create_office values
    max_office_id = Office.maximum(:oid) || 0
    if Office.where(
      values.slice(
        :member_id,
        :provides_offices_type,
        :provides_offices_id,
        :name,
        :year,
        )).blank?
      max_office_id += 1
      Office.unscoped.create!(values.merge(oid: max_office_id))
    end
  end
end