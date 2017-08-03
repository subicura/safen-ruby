class Safen
  class Header
    class << self
      # 전화번호 매핑
      def mapping_request(corp_code)
        create_header 110, '1001', corp_code
      end

      # 전화번호 매핑 수정
      def mapping_update_request(corp_code)
        create_header 170, '1003', corp_code
      end

      # 전화번호 매핑 해제
      def mapping_cancel_request(corp_code)
        create_header 30, '1002', corp_code
      end

      # 전화번호 매핑 조회
      def mapping_show_request(corp_code)
        create_header 20, '1004', corp_code
      end

      # 전문길이 (4byte) Header를 제외한 Body data size
      # 업무구분코드 (4byte)
      # 업체코드 (4byte) Telink 에서 부여.
      def create_header(len, code, corp_code)
        "#{len.to_s.ljust(4, ' ')}#{code}#{corp_code}"
      end
    end
  end
end