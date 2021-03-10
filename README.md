# BidMaster
> `BidMaster is freelancing platform which provides freelancers to bid on projects which are posted by clients.`

## _Overview:_
### Models used:
- User
- Project
- BiddingProfile
- Bid
- Conversation
- Message
- Notification

# Project
```ruby
belongs_to :client, class_name: 'User'
has_many :bids
```
> if a `user` is a client then user can post many `projects` ,and a project can receive many `bids(proposals)`

# Bidding Profile
```ruby
belongs_to :freelancer, class_name: 'User'
```
> if a `user` is freelancer,then user would have  one `bidding Profile` which holds user's category('web developer','graphic designer' etc) &  user's bio and the expertise(beginner , intermediate,expert ) in that particular field. 

# Bid
```ruby
belongs_to :project
belongs_to :freelancer, class_name: 'User
has_many :notifications
```
> user can place a `bid` on a `project` and `bid` is placed by a `freelancer` & after a `bid` is placed a `notification` is sent to a `client` who posted that project,once `client` approve or reject a `notification` is sent to `freelancer`

# Conversation
```ruby
 belongs_to :sender, class_name: 'User'
 belongs_to :recipient, class_name: 'User'
 has_many :messages
```
> a conversation a always between two `users` and a `conversation` can have many `messages` 

# Message
``` ruby
 belongs_to :user
 belongs_to :conversation
```
# Notification
``` ruby
 belongs_to :user
 belongs_to :bid
```
> `notification` is created when `freelancer` place a `bid` & when `client's` respond to the `bid`.
