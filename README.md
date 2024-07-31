# Little Esty Shop

## Background and Description

"Little Esty Shop" is a Turing School of Software & Design group project for BackEnd Mod 2 students that builds a fictitious e-commerce platform. The functionality mimics an environment where merchants and admins can manage inventory and fulfill customer invoices. The application is built with Ruby 3, using the Rails 7 framework, and makes use of a Postgres relational database seeded with data provided from the course instructors. The application makes use of the following gems: capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, and launchy. ActiveRecord is used as the ORM.

The application is designed to serve two different user bases, or opperate in two different *modes*. The *admin* and *merchant* mode have that have their own respective views and controllers while making use of the same models, data, and database. 

The application is a work in progress, and though fully functional with the code base we have, there are some features not implemented. We do plan to implement them in the future to continue our learning and familiarization with core Rails concepts. 

In the event this project were to be passed onto a different set of software engineers, we would recommend first attacking the rest of the user stories before any refactoring is conducted. After the user stories are complete, we would look into implementing partials to *dry* up our code within the views, and continue to build out our test suite to include additional edge cases and more robust *sad path* scenarios. In tandom, we would implement flash error messaging.

## Schema Layout 
![Screenshot 2024-07-23 at 2 13 04 PM](https://github.com/user-attachments/assets/0e18f99c-5b43-4b3a-ac7a-febaff7c7a21)

## Colaborators 
* Cory Bretsch: [GitHub](https://github.com/CoryBretsch)
* James Cochran: [GitHub](https://github.com/James-Cochran)
* Lito Croy: [GitHub](https://github.com/litobot)
* Karl Fallenius: [GitHub](https://github.com/SmilodonP), [LinkedIn](https://www.linkedin.com/in/karlfallenius/)
* Jan Lehigh: [GitHub](https://github.com/JCL461437)

## Project Board
We made use of a GitHub Project board to track our progress on the user stories. We made additional cards to track bugs we encountered, potential refactoring endeavors, and solo spike opportunities. Our project board can be found [here](https://github.com/users/SmilodonP/projects/1).

## Learning Goals
- Practice working with and managing a large code base within a group of 5 over the span of a week
- Practice designing a normalized database schema and defining model relationships
- Build custom rake commands to import data from csv files to the database
- Utilize advanced routing techniques including namespacing to organize and group like functionality together
- Utilize advanced active record techniques to perform complex database queries

## Project Outline & Phases
1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
