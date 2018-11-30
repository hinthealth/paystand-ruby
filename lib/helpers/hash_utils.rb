module HashUtils
  extend self
  # extracted from https://github.com/futurechimp/awrence
  def to_camelback_keys(value = self)
    case value
    when Array
      value.map { |v| to_camelback_keys(v) }
    when Hash
      Hash[value.map { |k, v| [camelize_key(k), to_camelback_keys(v)] }]
    else
      value
    end
  end

  private

  def camelize_key(k)
    if k.is_a? Symbol
      camelize(k.to_s, false).to_sym
    else
      k # we keep strings and other objects as they are
    end
  end

  def camelize(snake_word, first_upper = true)
    if first_upper
      snake_word.to_s
        .gsub(/(?:^|_)([^_\s]+)/) { Regexp.last_match(1).capitalize }
        .gsub(%r{/([^/]*)}) { '::' + Regexp.last_match(1).capitalize }
    else
      parts = snake_word.split('_', 2)
      parts[0] << camelize(parts[1]) if parts.size > 1
      parts[0] || ''
    end
  end
end
