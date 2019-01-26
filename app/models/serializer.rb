require 'jwt'

class Serializer
  def encode(payload)
    JWT.encode(
      payload,
      nil,
      'none'
    )
  end

  def decode(token)
    payload, _header =
      JWT.decode(
        token,
        nil,
        false
      )

    {
      name: payload['name']
    }
  end
end
