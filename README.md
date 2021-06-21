# テーブル

### users
- id
- name:string
- email:string
- password_digest:string

### tasks
- id
- user_id:integer
- name:string
- discription:text
- priority:integer
- deadline:date
- status:integer


### labeling
- id
- task_id:integer
- label_id:integer

### label
- id
- name:string
