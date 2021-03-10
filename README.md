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

# _`Features`_ 
#  SignUp & SignIn
![Screenshot_2021-03-10 BidMaster(2)](https://user-images.githubusercontent.com/41575688/110678922-daf28280-81fc-11eb-9b2e-29b1d2cee816.png) ![Screenshot_2021-03-11 BidMaster(1)](https://user-images.githubusercontent.com/41575688/110680443-9ff14e80-81fe-11eb-878b-18d91002095d.png)
> when someone visit the site they can navigate to `signUp ` page and sign Up by providing neccessary details,and after registration they can log into their accounts.

# User as a client
![Screenshot_2021-03-11 BidMaster(4)](https://user-images.githubusercontent.com/41575688/110682225-b5677800-8200-11eb-8823-3d631b20356a.png)

![Screenshot_2021-03-11 BidMaster(5)](https://user-images.githubusercontent.com/41575688/110683017-99b0a180-8201-11eb-8890-bd514dfdf881.png)

![Screenshot_2021-03-11 BidMaster(6)](https://user-images.githubusercontent.com/41575688/110683024-9ae1ce80-8201-11eb-8892-3ab5aa063865.png)


![Screenshot from 2021-03-11 00-36-24](https://user-images.githubusercontent.com/41575688/110685770-a5519780-8204-11eb-99ef-7a4d680ffc16.png)

>  Once a `users` is logged in as a `Client` they can post a `project` get notified when a `freelancer` `bid` on their `project` and Client has a option to Accept or reject a `bid` once accepted client can choose  the desired freelancer and `award` them the project. 

# User as a Freelancer
`
![Screenshot_2021-03-11 BidMaster(8)](https://user-images.githubusercontent.com/41575688/110688035-2a3db080-8207-11eb-9c7b-60f62ced2dc8.png)
> `when users logged in as  freelancer,they can place  bid on project.`

![Screenshot from 2021-03-11 01-08-10](https://user-images.githubusercontent.com/41575688/110687411-79cfac80-8206-11eb-8ff5-046b48e6aeac.png)
> `freelancer bid history`


![Screenshot from 2021-03-11 01-09-02](https://user-images.githubusercontent.com/41575688/110687419-7b997000-8206-11eb-9fd0-96c987d056e8.png)
>Freelancer getting notified on their respective bids.

![Screenshot from 2021-03-11 01-09-06](https://user-images.githubusercontent.com/41575688/110687421-7c320680-8206-11eb-9ecb-bcb5ccc48cd0.png)
> Freelancer's Bidding Profile

