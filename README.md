Rack приложение, которое отвечает на `URL GET /time` с параметром строки запроса format и возвращает время в заданном формате. 

```
GET /time?format=year%2Cmonth%2Cday
# => 200 text/plain 1970-01-01
```

Доступные форматы времени: `year`, `month`, `day`, `hour`, `minute`, `second`.

Форматы передаются в любом порядке

Если среди форматов времени присутствует неизвестный формат, то возвращается ответ с кодом статуса 400 и телом `Unknown time format [epoch]`.

Если неизвестных форматов несколько, то они будут перечислены: `Unknown time format [epoch, age]`.

При запросе на любой другой URL возвращается ответ с кодом статуса 404

```
$ cd "/app/dir"
$ rakeup

# app test
curl --url 'localhost:9292/time?format=year,day,hour' -i # => 200
curl --url 'localhost:9292/TEST?format=year,day,hour' -i # => 404
curl --url 'localhost:9292/time?format=year,un,known' -i # => 400
```
