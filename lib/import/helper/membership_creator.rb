module MembershipCreator
  extend self

  def create_current_memberships doc
    doc.xpath('//MEMBER').each do |member_node|
      in_club_since = member_node['membershipStart'].to_date
      member_id = member_node['id'].to_i
      club_id = member_node.parent.parent['id'].to_i

      Membership.create!(
        {
          from: in_club_since,
          member_id: member_id,
          club_id: club_id,
        }
      )
    end
  end

  def create_past_membership doc
    doc.xpath('//PREVCLUB').each do |prevclub_node|
      member_id = prevclub_node.parent.parent['id'].to_i
      club_id = prevclub_node['id'].to_i
      years = prevclub_node.xpath('./YEAR').text.split('-')
      start_date = "#{years.first}-07-01".to_date
      end_date = "#{years.last}-06-30".to_date

      Membership.create!(
        {
          from: start_date,
          to: end_date,
          member_id: member_id,
          club_id: club_id,
        }
      )
    end
  end
end