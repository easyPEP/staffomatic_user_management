class JwtAuthenticationService

  def self.encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def self.decode_token(request)
    auth_token = self.parse_auth_header(request)
    return unless auth_token.present?

    decoded_token = begin
      t = JWT.decode(auth_token, 's3cr3t', true, algorithm: 'HS256')
      t[0]['user_id']
    rescue JWT::DecodeError
      nil
    end

    return decoded_token
  end

  def self.parse_auth_header(request)
    # { Authentication: 'Bearer <token>' }
    auth_header = request.headers['Authentication']
    return unless auth_header && auth_header.split(' ').present?

    return auth_header.split(' ')[1]
  end
end