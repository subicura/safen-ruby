module Safen
  class Body
    class << self
      # 전화번호 매핑
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

      # 전화번호 매핑 수정
      def mapping_update_request(old_tel_num, new_tel_num, group_code)
        default_old_tel_num = '1234567890'
        old_tel_num_nomalize = old_tel_num.gsub(/-/, '')
        new_tel_num_nomalize = new_tel_num.gsub(/-/, '')

        ret = ''
        ret += "#{new_tel_num_nomalize.ljust(20, ' ')}"
        ret += "#{default_old_tel_num.ljust(20, ' ')}#{old_tel_num_nomalize.ljust(20, ' ')}"
        ret += "#{default_old_tel_num.ljust(20, ' ')}#{old_tel_num_nomalize.ljust(20, ' ')}"
        ret += "#{group_code.ljust(10, ' ')}"
        ret += "#{' ' * 50}#{' ' * 10}"

        ret
      end

      # 전화번호 매핑 해제
      #
      # 설명 offset, length
      # 0504 매핑번호 0, 20 (매핑된 전화번호)
      # 그룹코드 20, 10 (수정할 그룹코드)
      def mapping_cancel_request(new_tel_num, group_code)
        tel_num = new_tel_num.gsub(/-/, '')
        "#{tel_num.ljust(20, ' ')}#{group_code.ljust(10, ' ')}"
      end
    end
  end
end
