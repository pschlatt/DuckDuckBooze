# DuckDuckBooze

## About

DuckDuckBooze is a group project between four students while at Turing School of Sofware and
Design's Backend Engineering program. The aim of the project is to hone the following skills:

- Advanced database queries and manipulation using ActiveRecord and SQL 
- Basic HTML/CSS layout and design for UX/UI
- Authentication & Authorization with bcrypt
- Session management to authenticate different users and each user's respective cart
- MVC design pattern
- CRUD and RESTful routes, with nested resources and namspacing
- TDD using RSpec and Capybara 
- Version control and project management within a group environment 

The project is a Rails web application that acts as an e-commerce platform with three types of users: registered users, merchants, and admins. Registered users can put items into shopping cart and check out to purchase; visitors can fill carts but must registered to complete the purchase. Merchants sell items, which they can change the fulfillment status of. The last merchant to fulfill a specific order sets that order to 'shipped'. Admin can edit both registered users and merchants accounts such as downgrade/upgrade role or enable/disable their account. Each user has defined roles and these roles vary the user's permission to access pages within the web application.

### Database Schema
![schema](duckduckbooze_schema.png)

## Installation & Setup 

The program can run in development from the Rails server after following the following steps in your console:

* clone to a local repository using ` git clone https://github.com/pschlatt/DuckDuckBooze.git`
* change directory into the app with `cd DuckDuckBooze`
* run `bundle install`
* initialize the database with `rake db:{drop, create, migrate, seed}`
* start the rails server with `rails s`
* The terminal output will show the IP address to type into the browser in order to see the project (for example, localhost:3000)

The following is a screenshot of the landing page: 

![landing](Screen%20Shot%202019-04-10%20at%205.05.21%20PM.png)

## Testing

The project uses <a href="https://github.com/colszowka/simplecov"> SimpleCov</a> and <a href="https://github.com/rspec/rspec"> RSpec</a> to test. 

`rspec` runs the tests.

## Live Web App

The project is in live production <a href="http://serene-temple-51699.herokuapp.com"> here</a> 

To login as a registered user, you can register a new account or use email: `sally@gmail.com password: 12345678`

To login as a merchant `email: mike@gmail.com password: password`

To login as admin, `email: aaron@gmail.com password: password`

## System Requirements

Ruby on Rails, version 5.1.7.  
Postgresql, version 11.2 

## Contributors

`Corey Sheesley @csheesley`

`Earl Stephens @earl-stephens`

`Paul Schlattmann @pschlatt`

`Chi Tran @chitasan`
