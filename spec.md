# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Sinatra has been used to create controllers & a config.ru folder. These files send and receive HTTP requests that interact with my models and database.
- [X] Use ActiveRecord for storing information in a database - ActiveRecord model relationships & CRUD methods were utilized throughout to associate users/contacts/facts, locate specific instances, and overall refactor code.
- [X] Include more than one model class (e.g. User, Post, Category) - This app has three model classes - Users, Contacts, and Facts.
- [X] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - Users have many contacts, and contacts have many facts.
- [X] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - Contacts belong to users, and facts belong to contacts.
- [X] Include user accounts with unique login attribute (username or email) - Using bcrypt, a secure password was implemented. Using ActiveRecord validations at user creation, the username is checked for length & uniqueness, the email is checked for email format & uniqueness, and the password is checked for length.
- [X] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - The contact model has restful routes in the contacts controller to create, read, update, and destroy contacts. The facts model also has a route to destroy.
- [X] Ensure that users can't modify content created by other users - Application controller helper methods logged_in? and right_user? ensure that the user can only view certain pages when logged in, and that the user's session id matches the resource's assigned user id.
- [X] Include user input validations - New contact information & patch information has validations to ensure that code only runs when user fills out the applicable fields. It also checks for proper syntax for updating feature.
- [X] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - Flash messages installed for user login, user creation, and contact creation features.
- [X] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - README was updated to feature similar format to my first project, ten_largest_cities.

Confirm
- [X] You have a large number of small Git commits - Definetly need more commits in the middle of the project, but I am learning compared to my first project.
- [X] Your commit messages are meaningful - Tried to update commit messages to specifically which problem I was tackling and why.
- [X] You made the changes in a commit that relate to the commit message - I know that I made this mistake a lot earlier on, but I was improving as the project continued.
- [X] You don't include changes in a commit that aren't related to the commit message - There were a few times this was broken because I got distracted. but improving.
