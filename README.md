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
Safen.create corp_code, old_tel_num, group_code
```

**params**

- `corp_code`: 업체코드
- `old_tel_num`: 실제 사용중인 착신번호
- `group_code`: 그룹코드

**ret**

연동 성공시 연동된 0504 전화번호, 실패시 결과 코드표 참고

### 수정 요청

```
Safen.update corp_code, old_tel_num, group_code, new_tel_num
```

**params**

- `corp_code`: 업체코드
- `old_tel_num`: 실제 사용중인 착신번호
- `group_code`: 그룹코드
- `new_tel_num`: 맵핑할 번호

**ret**

연동 성공시 0000, 실패시 결과 코드표 참고

### 취소 요청

```
Safen.remove corp_code, new_tel_num, group_code
```

**params**

- `corp_code`: 업체코드
- `new_tel_num`: 0504 연동 번호
- `group_code`: 그룹코드

**ret**

연동 성공시 0000, 실패시 결과 코드표 참고


### 결과 코드표



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/subicura/safen.
