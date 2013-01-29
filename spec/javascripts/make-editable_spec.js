describe('make-editable', function(){
  describe('convertToHash', function(){
    it('converts empty object correctly', function(){
      expect(MyApp.convertToHash.apply({})).toEqual({});
      });

    it('converts basic link to correct hash', function(){
      var inputObject = {
        fieldTitle: 'This is the title',
        fieldCaption: 'This is the caption'
      };

      var expectedObject = {
        title: 'This is the title',
        caption: 'This is the caption'
      };

      expect(MyApp.convertToHash.apply(inputObject)).toEqual(expectedObject);
    });

    it('ommits additional data', function(){
      var inputObject = {
        fieldTitle: 'This is the title',
        fieldCaption: 'This is the caption',
        somethingStrange: 'This will be ommited'
      };

      var expectedObject = {
        title: 'This is the title',
        caption: 'This is the caption'
      };

      expect(MyApp.convertToHash.apply(inputObject)).toEqual(expectedObject);
    });
  });

  describe('initEditable', function(){
    it('inits text attribute field correctly', function(){
      loadFixtures('memberEditable');
      MyApp.initEditable(123, [$('#first_name')], '/new', 'superSecret');
      var editableOptions = $('#first_name').data('editable').options;
      expect(editableOptions.pk).toEqual(123);
      expect(editableOptions.type).toEqual('text');
      expect(editableOptions.ajaxOptions).toEqual({type: 'patch'});
      expect(editableOptions.params).toEqual({authenticity_token: 'superSecret'});
      expect(editableOptions.url).toEqual('/new');
    });

    it('inits select attribute field correctly', function(){
      loadFixtures('memberEditable');
      MyApp.initEditable(123, [$('#gender')], '/new', 'superSecret');
      var editableOptions = $('#gender').data('editable').options;
      expect(editableOptions.pk).toEqual(123);
      expect(editableOptions.type).toEqual('select');
      expect(editableOptions.source).toEqual([{value: 'female', text: 'Female'}, {value: 'male', text: 'Male'}]);
      expect(editableOptions.ajaxOptions).toEqual({type: 'patch'});
      expect(editableOptions.params).toEqual({authenticity_token: 'superSecret'});
      expect(editableOptions.url).toEqual('/new');
    });

    it('inits date attribute field correctly', function(){
      loadFixtures('memberEditable');
      MyApp.initEditable(123, [$('#member_since')], '/new', 'superSecret');
      var editableOptions = $('#member_since').data('editable').options;
      expect(editableOptions.pk).toEqual(123);
      expect(editableOptions.type).toEqual('date');
      expect(editableOptions.datepicker).toEqual({language: 'en'});
      expect(editableOptions.ajaxOptions).toEqual({type: 'patch'});
      expect(editableOptions.params).toEqual({authenticity_token: 'superSecret'});
      expect(editableOptions.url).toEqual('/new');
    });

    it('inits multiple selector correctly', function(){
      loadFixtures('memberEditable');
      MyApp.initEditable(123, $('.edit-member'), '/new', 'superSecret');
      $.each([$('#first_name'), $('#gender'), $('#member_since')], function(){
        expect($(this).data('editable').options).toBeDefined();
      });
    });
  });
});