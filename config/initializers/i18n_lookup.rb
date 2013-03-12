class I18n::Backend::Simple
  module Implementation

  protected

    def lookup(locale, key, scope = [], options = {})
      init_translations unless initialized?
      keys = I18n.normalize_keys(locale, key, scope, options[:separator])

      keys.inject(translations) do |result, _key|
        _key = _key.to_sym
        unless result.is_a?(Hash) && result.has_key?(_key)
          print_debug_message(keys, caller)   # print key that was not found!
          return nil
        end
        result = result[_key]
        result = resolve(locale, _key, result, options.merge(:scope => nil)) if result.is_a?(Symbol)
        result
      end
    end

    def print_debug_message(keys, caller)
      caller_line = caller.detect{|f| f !~ /i18n/}
      (Gem.paths.path.clone << ENV['HOME']).each { |base| caller_line.sub!(base, '...') }

      puts %|I18n: couldn't find "\e[1;33m#{keys.map(&:to_s).join('.')}\e[0;0m"\n  (from #{caller_line})}|
    end
  end
end if Rails.env.development?