# BidMaster
> `BidMaster is freelancing platform which provides freelancers to bid on projects which are posted by clients.`

# Installation
Follow these easy steps to install and start the app:
### Set up Rails app
```ruby 
bundle install
rails db:prepare
```
### Start the server
> rails s 


#####  _`TO access admin panel`_

> email: `admin@example.com` <br/>
password: `password`


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


>  Once a `users` is logged in as a `Client` they can post a `project` get notified when a `freelancer` `bid` on their `project` and Client has a option to Accept or reject a `bid` once accepted client can choose  the desired freelancer and `award` them the project. 

# User as a Freelancer
`
![Screenshot_2021-03-11 BidMaster(8)](https://user-images.githubusercontent.com/41575688/110688035-2a3db080-8207-11eb-9c7b-60f62ced2dc8.png)
> `when users logged in as  freelancer,they can place  bid on project.`

![Screenshot_2021-03-11 BidMaster(15)](https://user-images.githubusercontent.com/41575688/110695893-6b868e00-8210-11eb-982a-74f803490673.png)
> `freelancer bid history`


![Screenshot_2021-03-11 BidMaster(17)](https://user-images.githubusercontent.com/41575688/110695902-6de8e800-8210-11eb-8369-f6522549cda5.png)
>  Freelancer getting notified on their respective bids.

![Screenshot_2021-03-11 BidMaster(16)](https://user-images.githubusercontent.com/41575688/110695899-6d505180-8210-11eb-8d78-4735330e2aab.png)
> Freelancer's Bidding Profile.


# Messaging-feature



>   ### _When clients want to award a project they can chat with freelancers and choose the desired freelancer_
![Screenshot_2021-03-11 BidMaster(10)](https://user-images.githubusercontent.com/41575688/110692063-f31dce00-820b-11eb-8215-74fb73b8779a.png)

![Screenshot_2021-03-11 BidMaster(9)](https://user-images.githubusercontent.com/41575688/110691901-bc47b800-820b-11eb-9385-2c4c8db97418.png)





# _Search Functionality_
> ### To search projects or  freelancers click on the arrow on left of the search bar ,it gives a dropdown if anyone want to search  freelancers or projects

![Screenshot_2021-03-11 BidMaster(11)](https://user-images.githubusercontent.com/41575688/110693852-ed28ec80-820d-11eb-86ab-c8db4046367d.png)


![Screenshot_2021-03-11 BidMaster(12)](https://user-images.githubusercontent.com/41575688/110693855-eef2b000-820d-11eb-9c5c-f62f4a54ec85.png)
> ### _searching   projects_


![Screenshot_2021-03-11 BidMaster(13)](https://user-images.githubusercontent.com/41575688/110693857-ef8b4680-820d-11eb-9380-9665203ffb2c.png)
> ### _searching  freelancers_


![Screenshot_2021-03-11 BidMaster(14)](https://user-images.githubusercontent.com/41575688/110693865-f023dd00-820d-11eb-94b2-f71c18a012b0.png)
> # _search  filters_

