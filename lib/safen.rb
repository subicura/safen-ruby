require 'socket'
require 'safen/version'
require 'safen/header'
require 'safen/body'
require 'safen/error'

module Safen
  SAFEN_API_TEST_SERVER_ENDPOINST = ['211.237.78.41:48880']
  SAFEN_API_REAL_SERVER_ENDPOINST = ['211.237.78.41:48880']

  def self.call_api(header, body)
    ip, port = SAFEN_API_TEST_SERVER_ENDPOINST.first.split(':')
    ret = {}

    begin
      socket = TCPSocket.new(ip, port.to_i)
      socket.puts("#{header}#{body}")

      ret[:size] = socket.read(4).to_i
      ret[:code] = socket.read(4)
      ret[:corp_code] = socket.read(4)

      ret[:data] = socket.read(ret[:size])
    ensure
      socket.close
    end

    if ret[:code] == '2001'
      return ret[:data][0...20], ret[:data][20...24]
    end

    return nil, nil
  end

  def self.create(corp_code, old_tel_num, group_code)
    header = Header.mapping_request(corp_code)
    body = Body.mapping_request(old_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), 'Safen API call error'
    end

    data
  end
end
