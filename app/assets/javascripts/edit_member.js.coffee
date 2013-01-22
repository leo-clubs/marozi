class MemberEditableInitializer
  constructor: (@member_id, @member_update_url, @auth_token) ->

  init: ->
    for field in $('.edit-member')
      params = new EditableRenderer($(field).data()).toHash()
      params['pk'] = @member_id
      params['url'] = @member_update_url
      params['params'] = { authenticity_token: @auth_token }
      params['ajaxOptions'] = { type: 'patch' }
      $(field).editable params

class EditableRenderer
  constructor: (@data) ->

  toHash: ->
    hash = {}
    for key,value of @data
      if /^field/.test key
        hash[key.replace(/^field/,'').toLowerCase()] = value
    hash

@init_editable = ->
  member_id = $('#member').attr('data-leo-id')
  member_update_url = $('#member').attr('data-member-update-url')
  auth_token = $('meta[name="csrf-token"]').attr('content')
  new MemberEditableInitializer(member_id, member_update_url, auth_token).init()