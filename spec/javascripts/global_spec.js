describe('global',function(){
  describe('String.interpolate', function(){
    it('should not change string without vars', function(){
      expect('abc'.interpolate()).toEqual('abc');
    });

    it('should interpolate a string with one var correctly', function(){
      expect('/members/%{id}'.interpolate({id: '123'})).toEqual('/members/123');
    });

    it('should interpolate a string with multiple vars correctly', function(){
      expect('/%{type}/%{id}'.interpolate({id: '12', type: 'clubs'})).toEqual('/clubs/12');
    });    
  });
});