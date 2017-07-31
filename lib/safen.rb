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

    if ret[:code] == '2001' # 매핑 응답
      return ret[:data][20...24], ret[:data][0...20]
    elsif ret[:code] == '2002' # 해제 응답
      return ret[:data][0...4], nil
    elsif ret[:code] == '2003' # 수정 응답
      return ret[:data][0...4], nil
    end

    return nil, nil
  end

  # 매핑 요청
  # @param corp_code [String] 업체코드
  # @param old_tel_num [String] 실제 사용중인 착신번호
  # @param group_code [String] 그룹코드
  # @return [String] 매핑된 전화 번호
  def self.create(corp_code, old_tel_num, group_code)
    header = Header.mapping_request(corp_code)
    body = Body.mapping_request(old_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    data
  end

  # 수정 요청
  # @param corp_code [String] 업체코드
  # @param old_tel_num [String] 실제 사용중인 착신번호
  # @param group_code [String] 그룹코드
  # @param new_tel_num [String] 매핑할 번호
  # @return [bool] 성공여부
  def self.update(corp_code, old_tel_num, group_code, new_tel_num)
    header = Header.mapping_update_request(corp_code)
    body = Body.mapping_update_request(old_tel_num, new_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    true
  end

  # 취소 요청
  # @param corp_code [String] 업체코드
  # @param new_tel_num [String] 매핑할 번호
  # @param group_code [String] 그룹코드
  # @return [bool] 성공여부
  def self.remove(corp_code, new_tel_num, group_code)
    header = Header.mapping_cancel_request(corp_code)
    body = Body.mapping_cancel_request(new_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    true
  end
end
