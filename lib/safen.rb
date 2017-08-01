require 'socket'
require 'safen/version'
require 'safen/header'
require 'safen/body'
require 'safen/error'

class Safen
  attr_reader :api_server_entpoints, :corp_code

  # 고객코드와 api server endpoint 리스트로 초기화
  # @param corp_code [String] 고객코드
  # @param api_server_entpoints list[String] endpoint ip:port
  def initialize(corp_code, api_server_entpoints)
    @corp_code = corp_code
    @api_server_entpoints = api_server_entpoints
  end

  def call_api(header, body)
    ret = {}

    @api_server_entpoints.each_with_index do |endpoint, idx|
      ip, port = endpoint.split(':')

      begin
        socket = TCPSocket.new(ip, port.to_i)
        socket.puts("#{header}#{body}")

        ret[:size] = socket.read(4).to_i
        ret[:code] = socket.read(4)
        ret[:corp_code] = socket.read(4)

        ret[:data] = socket.read(ret[:size])

        break # 성공시 탈출
      rescue => e
        if idx == @api_server_entpoints.size - 1 # last
          raise e
        else
          next # 실패시 다음 엔드포인드 진행
        end
      ensure
        socket.close if socket
      end
    end

    if ret[:code] == '2001' # 매핑 응답
      return ret[:data][20...24], ret[:data][0...20].strip
    elsif ret[:code] == '2002' # 해제 응답
      return ret[:data][0...4], nil
    elsif ret[:code] == '2003' # 수정 응답
      return ret[:data][0...4], nil
    elsif ret[:code] == '2004' # 조회 응답
      return ret[:data][0...4], ret[:data][4...24].strip
    end

    return nil, nil
  end

  # 매핑 요청
  # @param old_tel_num [String] 실제 사용중인 착신번호
  # @param group_code [String] 그룹코드
  # @return [String] 매핑된 전화 번호
  def create(old_tel_num, group_code)
    header = Header.mapping_request(@corp_code)
    body = Body.mapping_request(old_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    data
  end

  # 수정 요청
  # @param old_tel_num [String] 실제 사용중인 착신번호
  # @param group_code [String] 그룹코드
  # @param new_tel_num [String] 매핑할 번호
  # @return [bool] 성공여부
  def update(old_tel_num, group_code, new_tel_num)
    header = Header.mapping_update_request(@corp_code)
    body = Body.mapping_update_request(old_tel_num, new_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    true
  end

  # 취소 요청
  # @param new_tel_num [String] 매핑할 번호
  # @param group_code [String] 그룹코드
  # @return [bool] 성공여부
  def remove(new_tel_num, group_code)
    header = Header.mapping_cancel_request(@corp_code)
    body = Body.mapping_cancel_request(new_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    true
  end

  # 매핑 조회 요청
  # @param new_tel_num [String] 매핑된 번호
  # @param group_code [String] 그룹 코드
  # @return [bool] 매핑된 전화 번호
  def show(new_tel_num, group_code)
    header = Header.mapping_show_request(@corp_code)
    body = Body.mapping_show_request( new_tel_num, group_code)

    code, data = call_api(header, body)

    if code != '0000'
      raise SafenError.new(code), "Safen API call error #{code}"
    end

    data
  end
end
