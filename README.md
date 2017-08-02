# Safen

SKT Safen 연동 API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'safen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install safen

## Usage

### 매핑 요청

```
Safen.new('xxxx', ['xxx.xxx.xxx.xxx:xxxx']).create old_tel_num, group_code
```

**params**

- `old_tel_num`: 실제 사용중인 착신번호
- `group_code`: 그룹코드

**ret**

연동 성공시 연동된 0504 전화번호, 실패시 결과 코드표 참고

### 수정 요청

```
Safen.new('xxxx', ['xxx.xxx.xxx.xxx:xxxx']).update old_tel_num, new_old_tel_num, group_code, new_tel_num
```

**params**

- `old_tel_num`: 기존 착신번호
- `new_old_tel_num`: 신규 착신번호
- `group_code`: 그룹코드
- `new_tel_num`: 0504 맵핑할 번호

**ret**

연동 성공시 0000, 실패시 결과 코드표 참고

### 취소 요청

```
Safen.new('xxxx', ['xxx.xxx.xxx.xxx:xxxx']).remove new_tel_num, group_code
```

**params**

- `new_tel_num`: 0504 연동 번호
- `group_code`: 그룹코드

**ret**

연동 성공시 0000, 실패시 결과 코드표 참고

### 매핑 조회

```
Safen.new('xxxx', ['xxx.xxx.xxx.xxx:xxxx']).show new_tel_num, group_code
```

**params**

- `corp_code`: 업체코드
- `new_tel_num`: 0504 연동 번호

**ret**

연동 성공시 연동된 착신번호, 해지된 안심번호 조회 요청시 E401

### 결과 코드표

| 코드 | 확인 | 설명 | 
|---|---|---|
| 0000 | 성공 처리 | 인증서버에서 요청 처리가 성공. |
| E101 | Network 장애 | 인증서버와 연결 실패. |
| E102 | System 장애. | 인증서버의 일시적 장애. 재시도 요망. |
| E201 | 제휴사 인증 실패. | 유효한 제휴사 코드가 아님. |
| E202 | 유효 기간 만료. | 제휴사와의 계약기간 만료. |
| E203 | 부가서비스 인증 실패 | 제휴사의 부가서비스 인증 실패. |
| E301 | 안심 번호 소진. | 유효한 안심번호 자원이 없슴. |
| E401 | Data Not Found | 요청한 Data와 일치하는 Data가 없슴. |
| E402 | Data Overlap | 요청한 Data가 이미 존재함. |
| E501 | 전문 오류 | 전문 공통부 혹은 본문의 Data가 비정상일 경우. |
| E502 | 전화 번호 오류 | 요청한 착신번호가 맵핑불가 번호일 경우 |
| E503 | 금칙어 오류 | 요청한 알림 내용이 금칙어를 포함한 경우 |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/subicura/safen.
