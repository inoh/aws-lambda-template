## AWS Lambda by Ruby

### 注意書き
AWS Lambda で Ruby を使ったサンプルとなるため、JWT のセキュリティについては、考慮が必要です。

### デプロイ

```
bundle install --without test
npx sls deploy
```

### テスト

```
bundle exec guard
```
