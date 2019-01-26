## Ruby AWS Lambda

デプロイ
```
bundle install --without test
npx sls deploy
```

テスト
```
docker pull amazon/dynamodb-local
docker run -p 8000:8000 amazon/dynamodb-local
bundle exec guard
```
