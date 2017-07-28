module Safen
  class Body
    class << self
      # 전화번호 맵핑
      #
      # 설명 offset, length
      # 착신번호1 0, 20 (연동할 전화번호)
      # 착신번호2 20, 20 (현재는 착신번호1과 동일하게 사용)
      # 그룹코드 40, 10 (수정할 그룹코드)
      # Reserved1 50, 50 (예약필드)
      # Reserved2 100, 10 (예약필드)
      def mapping_request(old_tel_num, group_code)
        tel_num = old_tel_num.gsub(/-/, '')
        "#{tel_num.ljust(20, ' ')}#{tel_num.ljust(20, ' ')}#{group_code.ljust(10, ' ')}#{' ' * 50}#{' ' * 10}"
      end

      # 전화번호 맵핑 해제
      #
      # 설명 offset, length
      # 0504 맵핑번호 0, 20 (맵핑된 전화번호)
      # 그룹코드 20, 10 (수정할 그룹코드)
      def mapping_cancel_request(new_tel_num, group_code)
        tel_num = new_tel_num.gsub(/-/, '')
        "#{tel_num.ljust(20, ' ')}#{group_code.ljust(10, ' ')}"
      end
    end
  end
end
