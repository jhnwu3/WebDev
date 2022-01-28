# **Mcdonalds Project 6 - Peer Evaluation Tool**
In this project, we design a peer evaluation tool to help students to provide feedback for each project.

# **Overview**
In this tool, the landing page will be the administrator sign up page. 


![Admin_page](https://user-images.githubusercontent.com/70242213/144694978-29b6e9a8-8686-416c-bcf7-1d4075329185.png)

-For the administrator:

**Only the administrator can sign up for an account.** 

To sign up for an account, administrators will be required to enter their name, email, password and password confirmation. 

To sign in the account, click on "Already have an account?" and enter your osu email (name.#@osu.edu) and password.

Then the administrator will create students account, which will require the administrators to enter the students name, email, password. The administrator can also create groups and project by clicking on the corrsponding button on the navigation bar.

-For the students:
To sign in the account, they can click on the "Already have an account?" button and enter their email and password.



# **Requirement**
To set up,please first clone the repository by 

    git clone https://github.com/cse3901-2021au-giles/mcdonalds-project6.git

To get all dependencies required for the project, please install these gems into your command line before running: 

    bundle install


Migrate the database:

    rails db:migrate
    
Install webpacker:

    rails webpacker:install

Just in case make sure to do:

    yarn

Then run the rails server:
 
    rails server
    
To visit the website, open the browser and type: 

    localhost:3000
    
# **Introduction**:

## Models

- admin
    This model is for all the administrators who will be managing their classes through this tool.

- user
    This model is for all the students who will be using the tool.

- evaluation
    This model is for all the evaluations that will be made by each student.

- group
    This model is for all the groups that students can be assigned to.

- grouping
    This is the grouping that associates user to group.

- ProjectGroup
    This is the association model between groups and projects.

- project
    This model is for all the projects that admins can create and manage.


## Views

- Admin View
    Admins have their own set of views for managing groups, users, and projects.

- User View
    Students will have the user views to view their own respective evalutions.

- Shared View
    All users and admins will go through a login screen.

## Controllers

## "Extra Features"

- Users can be in multiple groups, multiple groups can be in multiple projects, etc. (multiple group structures)
- If a user drops the course, admins can easily delete users.
- There is a login function for both admins and users.
- Basic analytics (was very hard) for admin view of evaluations

## "Features That Will Be Implemented (IF MORE TIME)" 
- A class code to separate into multiple classes + prevent easy admin abuse.
- Spreadsheet linking with Google's API for easy access to analysis functions provided by excel/google spreadsheets.

# **Testing**

In case rails test fails, perform:

    rake db:migrate
    rake db:test:prepare

Run to see basic testing:

    rails test

# Known issues (unsure of how to fix at this very moment)
- Evaluations sometimes may not list in the accordion
- Sometimes delete doesn't cascade such that you may get id errors.