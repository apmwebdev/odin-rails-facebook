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

### Users
- first name
- last name
- email
- password digest

### Friend requests
- sender
- recipient

### Friends
- user 1
- user 2

### Notifications
- title
- body

### Posts
- author
- body

### Post likes
- post id
- user id

### Post comments
- post id
- user id
- body

### Profile fields
- birthday
- age (calculated from birthday)
- gender