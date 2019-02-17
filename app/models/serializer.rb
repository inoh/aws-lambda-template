require 'openssl'
require 'jwt'

class Serializer
  def initialize
    # TODO: AWS KMS に持っていきたい
    @rsa_private = OpenSSL::PKey.read("-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAqrD2ZflmdTPZhnEyMvNSmwwIHbivXhHHrBAi/WRsXe5VHtmO\nMUAWkHAJiyoKdaIH8lMGojSFHjp9wmzn1Eh9yhHFq+xIaOEgshDo5ltISPLx37CD\nARLR/Z+DCMlVA1tMpJao0VGyadW61X48EuJCZEYavGx2wxPfv4eFVcLu+oJnQJiy\ndXYk9Mf9kn24B5sP0zDijr3PT26wdKlVHa6jvnWk2rCnTgS1U5eTgd9ZKkHipQjQ\nTBtQdTf9cjGycPCu+8KjUYBcsENscb/f6pffyC2K1M44ItcgQTgskmw+9r09q2MO\nGy/Je6yhBazHNQA7Ri52aSfkRDpZv2PwIxAfZQIDAQABAoIBABmuLiQBdczEVEHJ\n3geUXCU/likClD/O5P+aHemJplQre1r82EvInJx2frkVRiWUjyWCIElfJXf6zNjn\nkal6jpJMQjUvg2VkGYswyBmAOkvfYUyKPet3bWh/CzPTNpserVVF5Xg4lmMd6NId\n/+PHbr2vXm5i0yteXhduyDyy60l8/iXlpFjnFb/bYN+VI3oE6SaAgBRYsKWCTjAB\n4yTcVH+oH4sFqq+GuNER+DtWtGM6ulTQ7DPM5seIOavXzkO7WFjejwFsWph0leiP\nA/IRSDCSUqpsrM5UxCCnEtKegtLldcniXca5lcb+xz+tbVla0reK9e6V9jHNSoLa\nrHZYLwECgYEA14BRojsrj4ncjYGIzibPHFiFMstg1ysQ2cFC1VEa4tePc92NB7Ro\ndvOvAReKSZo9YEzPWFedoXk99jduq8FiwhSh1UKy7Jv5s8bo5FG0KQhJw/fxcx87\nYPv0krduw1gGEN1Dg4orXNejnHku8hba4cjTHcwQBcIsJID64UwQL/UCgYEAysTa\nRSCM4KKo88ev+p7W4JfPjZK9UesrlMwdnaNBxweY10f8h67Cjo4nrmwFhAlXjULZ\nlb4K9jeCxcy9/IUj43JSI4e0gyrYdYxIYNOjk853ydroAXufbAv1Gd0IWZ+J+xN+\nXmZ0KH9cQBjicLj82DvioSrbTVOK0xkYlsIbu7ECgYEAxiBObUXTNcN8x4iJG2do\n0Nm9lEaRgSEx+9GHvZE0k8u1MsRFLgk6ZeqCQhG/bQ3mUcwscT8USGmsgtrR4A0K\n2/6WDvikgY6hUxyT754CchsRnp8tGDdlozPh1qXYqrYZ1ZVnxd7ZISGMZYawl5hV\nonG9T07WiETNyr3eahZBZ6UCgYEAome21wUyML23isHWvmo4ety83Yy5XAJ6/ovZ\n8KeRCKOaFFvQ9K/RnrJXMAnPBSkiWb9AXQJA72IYuOq7BKVy0DqBdXm86A4KH2RD\nmGIKs1j8cs2FY6KrVrPhFV0G0hnJPzMm1N9EjCcuMRx9SYGw6lRUuXeE/NM77sY7\n/ovsAJECgYAZqDc2tezQXMflOcN92idp2cRgApILf30+okvo7kW11Ab6/I7yzeUV\nFwHX6zzbbY7MdgVAyCo7prPXdgi2rpOZxZYYTZQJYyF3VzSeTRRkvY1eL1LtHPh4\nMjI5wYHcW/XN4tbMkkVIr88xwT+XFqOnqm4l73zkQGXk7rtpXu7gDw==\n-----END RSA PRIVATE KEY-----\n")
    @rsa_public = OpenSSL::PKey.read("-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqrD2ZflmdTPZhnEyMvNS\nmwwIHbivXhHHrBAi/WRsXe5VHtmOMUAWkHAJiyoKdaIH8lMGojSFHjp9wmzn1Eh9\nyhHFq+xIaOEgshDo5ltISPLx37CDARLR/Z+DCMlVA1tMpJao0VGyadW61X48EuJC\nZEYavGx2wxPfv4eFVcLu+oJnQJiydXYk9Mf9kn24B5sP0zDijr3PT26wdKlVHa6j\nvnWk2rCnTgS1U5eTgd9ZKkHipQjQTBtQdTf9cjGycPCu+8KjUYBcsENscb/f6pff\nyC2K1M44ItcgQTgskmw+9r09q2MOGy/Je6yhBazHNQA7Ri52aSfkRDpZv2PwIxAf\nZQIDAQAB\n-----END PUBLIC KEY-----\n")
  end

  def encode(payload)
    JWT.encode(
      payload,
      rsa_private,
      'RS256'
    )
  end

  def decode(token)
    payload, _header =
      JWT.decode(
        token,
        rsa_public,
        true,
        algorithm: 'RS256'
      )

    payload
  end

  private

  attr_reader :rsa_private, :rsa_public
end
