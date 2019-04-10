# README

### What is DuckDuckBooze?

DuckDuckBooze is a four person group project that is part of the Turing School of Sofware and
Design's Backend Engineering Module 2 curriculum.  The aim of the project is to hone the following skills:

- Advanced Rails routing (nested resources and namespacing)
- Advanced ActiveRecord for calculating statistics
- Average HTML/CSS layout and design for UX/UI
- Session management and use of POROs for shopping cart
- Authentication, Authorization, separation of user roles and permissions

The project is an Rails application that acts as an e-commerce platform where users can place different selections of beer into a shopping cart and check out to purchase all of the items if they have also registered. Merchants can specify different selections of beer as "fulfilled" and the last merchant to do this for a specific order will automatically set the current order status (enum) to "shipped". Each user has roles and these roles vary the user's authorization to access some functionality within the models.

The following is a screenshot of the landing page: 

![landing](Screen%20Shot%202019-04-10%20at%205.05.21%20PM.png)

### How do I access use of this application?
The program can be ran in development from the Rails server after cloning to a local repository and running `bundle install`.  In the command line, type `rails s`.  The terminal output will show the IP address to type into the browser in order to see the project (for example, localhost:3000).  The public/production version of this application is available at:
http://serene-temple-51699.herokuapp.com

### Ruby Version
This project was written in Ruby on Rails, version 5.1.7.  

### Postgresql Version
Postgresql version 11.2 is the database that is used for the project.
