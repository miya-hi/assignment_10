# テーブル

### users
| type | column |
| :-------: | :------------: |
| integer | id |
| string | name |
| string | email |
| string | password_digest |


### tasks
| type | column |
| :-------: | :----------: |
| integer | id |
| integer | user_id |
| string | name |
| text | discription |
| date | deadline |
| integer | status |
| integer | priority |


### labeling
| type | column |
| :-------: | :---------: |
| integer | id |
| integer | task_id |
| integer | label_id |


### label
| type | column |
| :-------: | :-----: |
| integer | id |
| string | name |


#Herokuへのデプロイ方法
- Herokuにログイン
    heroku login
- Herokuアプリ作成
    heroku create
- アセットプリコンパイルを行う
    rails assets:precompile RAILS_ENV=production
- Herokuにデプロイ
    git push heroku master
    またはgit push heroku ローカルランチ名:master
