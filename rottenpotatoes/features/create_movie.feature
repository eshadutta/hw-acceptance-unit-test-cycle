Feature: add a new movie
 
 As a movie buff
 So that I always have my favorite lists
 I want to add a new movie

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  
  And I am on the RottenPotatoes home page

Scenario: add a new movie to the database
  When I follow "Add new movie"
  And  I fill in "Title" with "Example"
  And  I select "R" from "Rating"
  And  I press "Save Changes"
  Then I should see "Example"
