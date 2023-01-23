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
- user:references
- birthday:date
- gender
- bio:text
- country
- city

## To-Dos

## Eventual To-Dos
- Add confirmation to sign-up
- Cleanup:
  - Remove newsfeed route from home controller
  - Remove friend request status
- Make posts show author card of some sort, not just name
- Add validation
- Add unfriend functionality
- Make user search form work
- Add styling (maybe, see below)

## Maybe To-Dos
- Make comments and posts have same name for body/content
- Implement interests for profile. Separate table.
- Make location smarter (country, political subdivision, city)
- Make posts also allow images (either just via a URL or, more complicated, by
  uploading one).
- Use the Active Storage to allow users to upload a photo to their profile.
- Make your post able to be either a text OR a photo by using a polymorphic
  association (so users can still like or comment on it while being
  none-the-wiser).
- Style it up nicely! We’ll dive into HTML/CSS in the next course.