# Structure

## Models
- users
  - friend requests
  - friends
- notifications
- posts
  - post likes
  - post comments
- profile page fields (separate model? part of user?)

## Other aspects
- Devise
- Omniauth
- Mailer for welcome email

## Model Details

### Users (done)
- first name
- last name
- email
- password digest

### Friend requests (done)
- sender
- recipient
- status

### Friends (done)
- user 1
- user 2

### Notifications (done)
- title
- body
- status (read, unread, dismissed)
- user ref
- notifiable ref (polymorphic)
  - new friendship
  - new friend request
  - new comment
  - new like

### Posts (done)
- author
- body

### Likes (done)
- post or comment id (polymorphic as :likeable)
- user id

### Comments (done)
- commentable id (polymorphic)
- commenter id
- body

### Profile fields
- birthday
- age (calculated from birthday)
- gender

## To-Dos

## Eventual To-Dos
- Add unfriend functionality
- Make user search form work
- Remove friend request status
- Remove newsfeed route from home controller
- Make posts show author card of some sort, not just name
- Make comments and posts have same name for body/content