module AppleMusic
  delegate :get, to: :client

  # def initialize(secret_key_path:, team_id:, music_id:, token_expire_time: 1.day)
  def initialize
    @secret_key_path = Rails.application.credentials[apple_music_api][:apple_path1]
    @team_id = Rails.application.credentials[apple_music_api][:apple_iss]
    @music_id = Rails.application.credentials[apple_music_api][:apple_kid1]
    @token_expire_time = token_expire_time
    # @token_expire_time = Time.now.to_i + 3600
  end
  
  def verify_env
    puts "### ENV ###"
    puts @secret_key_path
    puts @team_id
    puts @music_id
    puts @token_expire_time
  end

  private
  def client
    @faraday ||= QApi::Faraday.without_cache_fallback(:url => 'https://api.music.apple.com/v1/') do |builder|
      builder.use FaradayMiddleware::ParseJson
      builder.authorization(:bearer, authentication_token)
    end
  end

  def authentication_payload
    {
      iss: @team_id,
      iat: Time.now.to_i,
      exp: @token_expire_time.from_now.to_i
    }
  end

  def authentication_token
    private_key = OpenSSL::PKey::EC.new(apple_music_secret_key)
    JWT.encode authentication_payload, private_key, 'ES256', kid: @music_id
  end

  def apple_music_secret_key
    @apple_music_secret_key ||= File.read(@secret_key_path)
  end
end
