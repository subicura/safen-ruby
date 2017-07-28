module Safen
  class Header
    class << self
      # 전화번호 생성
      def mapping_request(corp_code)
        create_header 110, '1001', corp_code
      end

      # 전문길이 (4byte) Header를 제외한 Body data size
      # 업무구분코드 (4byte)
      # 업체코드 (4byte) Telink 에서 부여.
      def create_header(len, code, corp_code)
        "#{len.to_s.rjust(4, '0')}#{code}#{corp_code}"
      end
    end
  end
end