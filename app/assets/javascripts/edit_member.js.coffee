class MemberEditableInitializer
  constructor: (@member_id, @member_update_url, @auth_token) ->

  init: ->
    for field in ['first_name', 'last_name']
      $("##{field}").editable
        type: "text"
        pk: @member_id
        url: @member_update_url
        title: "Enter username"
        params:
          authenticity_token: @auth_token
        ajaxOptions:
          type: 'patch'

@init_editable = ->
  member_id = $('#member').attr('data-leo-id')
  member_update_url = $('#member').attr('data-member-update-url')
  auth_token = $('meta[name="csrf-token"]').attr('content')
  new MemberEditableInitializer(member_id, member_update_url, auth_token).init()