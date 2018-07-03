module Lufthansa
  module Helper
    def camelize(underscored_word)
      underscored_word.to_s.gsub(/(.?:^|_)(.)/) { $2.upcase }
    end

    def classify(value)
      camelize value.to_s.capitalize
    end

    def demodulize(class_name_in_module)
      class_name_in_module.to_s.sub(/^.*::/, '')
    end

    def pluralize(word)
      word.to_s.sub(/([^s])$/, '\1s')
    end

    def singularize(word)
      return word if word.match(/status$/i)
      if word.to_s =~ /ses$/
        word.to_s.sub(/es$/, '')
      else
        word.to_s.sub(/s$/, '').sub(/ie$/, 'y')
      end
    end

    def underscore(camel_cased_word)
      word = camel_cased_word.to_s.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr! '-', '_'
      word.downcase!
      word
    end

    def hash_with_indifferent_read_access(base = {})
      indifferent = Hash.new { |hash, key| hash[key.to_s] if key.is_a? Symbol }
      base.each_pair { |key, value| indifferent[key.to_s] = value }
      indifferent
    end

    def stringify_keys!(hash)
      hash.keys.each do |key|
        stringify_keys! hash[key] if hash[key].is_a? Hash
        hash[key.to_s] = hash.delete key if key.is_a? Symbol
      end
    end

    def camelize_keys!(hash)
      stringify_keys!(hash)
      hash.keys.each do |key|
        camelize_keys!(hash[key]) if hash[key].is_a? Hash
        hash[camelize(key)] = hash.delete(key)
      end
    end

    extend self
  end
end
