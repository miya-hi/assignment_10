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
