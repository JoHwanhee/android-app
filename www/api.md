
기본 url : https://api.mohagae.ga/api/v1  
임시 url : http:/mohagae.ga/api/v1

200	클라이언트의 요청을 정상적으로 수행함 (GET, PUT, PATCH or DELETE.)
```json
{
  "code" : "N0000",
  "message" : "success"
  "data" : [] or {}
}
```

201	클라이언트가 어떠한 리소스 생성을 요청, 해당 리소스가 성공적으로 생성됨(POST)
```json
{
  "code" : "N0000",
  "message" : "created" 
  "data" : [] or {}
}
```

400	클라이언트의 요청이 부적절 할 경우 사용하는 응답 코드
```json
{
  "code" : "E0000",
  "message" : "param error"
  "data" : null
}
```

401	클라이언트가 인증되지 않은 상태에서 보호된 리소스를 요청했을 때 사용하는 응답 코드
```json
{
  "code" : "E0001",
  "message" : "auth error"
  "data" : null
}
```

404 Page not found

405	클라이언트가 요청한 리소스에서는 사용 불가능한 Method를 이용했을 경우 사용하는 응답 코드

500	internal server error

|메소드 | 리소스| 내용|
|--|--|--|
GET| [/shops](./get-shops.md) | 현재 위치를 기준으로 관련된 가게 정보를 모두 불러온다. |
POST| [/shops](./post-shops.md) | 가게를 새로 생성한다. |
GET| [/shops/{id}](./get-shops-detail.md) | 특정 가게의 상세 정보를 호출한다. |
PUT | [/shops/{id}](./update-shop.md) | 특정 가게의 정보를 수정한다. |
PATCH | [/shops/{id}](./patch-shop.md) | 특정 가게의 정보를 일부 수정한다. |
DELETE | [/shops/{id}](./delete-shop.md) | 특정 가게의 정보를 삭제한다. |
