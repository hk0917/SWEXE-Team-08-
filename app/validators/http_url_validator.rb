class HttpUrlValidator < ActiveModel::EachValidator
  DEFAULT_MESSAGE = "は http:// か https:// で始まる正しいURLにしてください".freeze

  # モデルの検証と、表示側の再チェックで、同じ判定を使う
  def self.http_url?(value)
    uri = URI.parse(value.to_s)
    uri.is_a?(URI::HTTP) && uri.host.present? # URI::HTTPS は URI::HTTP のサブクラス
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, options[:message] || DEFAULT_MESSAGE) unless self.class.http_url?(value)
  end
end