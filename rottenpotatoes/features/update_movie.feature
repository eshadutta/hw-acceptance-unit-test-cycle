Feature: edit an existing movie
 
 As a movie buff 
 So that I can keep my movie list up to date
 I want to update movie title and rating

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  
  And I am on the RottenPotatoes home page

Scenario: update an existing movie in the database
  When I go to the edit page for "Star Wars"
  And  I fill in "Title" with "Star Wars II"
  And  I press "Update Movie Info"
  Then I should see "Star Wars II" 
