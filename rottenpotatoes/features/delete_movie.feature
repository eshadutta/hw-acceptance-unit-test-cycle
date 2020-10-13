Feature: delete an existing movie
 
 As a movie lover 
 So that I can delete movies I did not like
 I want to delete movies

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  
  And I am on the RottenPotatoes home page

Scenario: delete an existing movie from the database
  Given I am on the details page for "Star Wars"
  When I press "Delete"
  Then I should see "Movie 'Star Wars' deleted"
