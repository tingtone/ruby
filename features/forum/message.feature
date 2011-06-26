Feature: Private message
  In order to send and check my private message
  As a user
  I want to visit message page to see them

  Background: Logged in
    Given I sign up with "lz/edison@kittypad.com/111111/111111"
    And sign up with "Bob/bob@kittypad.com/222222/222222"
    And I sign in with "edison@kittypad.com/111111"

    Scenario: Check my message
      Given Bob send me a message
      When I go to the inbox message page
      Then I should see "Bob"

    Scenario: send new message successfully
      Given I am on new message page
      When I write a message with "Bob/Hello/Welcome to Kittypad"
      Then I should be on the inbox message page
      And I am on the outbox message page
      Then I should see "lz"

    Scenario: send new message fail
      Given I am on new message page
      When I write a message with "NotExistUser/Hello/This is failure example"
      Then I should see "Topic Create UnSuccessfully.Recipent not exist!"

    Scenario: send new group message successfully
      Given I am on new message page
      When I write a message with "Bob/Hello/Welcome to Kittypad" checking group
      Then I should be on the inbox message page
      Then I should see "lz"

