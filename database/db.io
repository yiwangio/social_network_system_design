// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table users {
  id integer [primary key]
  nickname string [unique, not null]
  name string [not null]
  password string [not null]
  created_at datetime [not null]
  followers integer 
  following integer
  post_counter integer
  email string [unique]
  phone string [unique, not null]
}


Table posts {
  id uuid [primary key]
  body text [note: 'Content of the post']
  user_id integer 
  created_at timestamp [not null]
  location_id integer 
  comments_counter integer
  reaction_counter integer
}

Table media {
  id integer [primary key]
  img_url string [unique, not null]
  post_id integer [not null]
}

Table locations {
  id uuid [primary key]
  name string [not null]
  lo double
  la double
}

Table comments {
  id integer [primary key]
  body text
  post_id integer 
  user_id integer
  parrent_id integer [note: 'Reply to somebodys comment. Only one parent']
}

Table users_following {
  id integer [primary key]
  follower integer
  following integer
}

Table marks {
  id integer [primary key]
  post_id integer
  user_id integer
  reaction_id integer
}

Ref: posts.user_id > users.id // many-to-one
Ref: media.post_id > posts.id // many-to-one

Ref: "posts"."location_id" > "locations"."id"

Ref: "comments"."post_id" > "posts"."id"

Ref: "comments"."user_id" > "users"."id"

Ref: "comments"."parrent_id" > "comments"."id"


Ref: "users"."id" < "users_following"."follower"

Ref: "users"."id" < "users_following"."following"

Ref: "posts"."id" <> "marks"."post_id"

Ref: "users"."id" <> "marks"."user_id"
