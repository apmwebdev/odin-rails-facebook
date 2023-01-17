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

### Posts
- author
- body

### Likes
- post or comment id (polymorphic as :likable)
- user id

### Post comments
- post id
- user id
- body

### Profile fields
- birthday
- age (calculated from birthday)
- gender

## To-Dos
- Make posts

## Eventual To-Dos
- Add unfriend functionality
- Make user search form work
- Remove friend request status
- Make things use Turbo