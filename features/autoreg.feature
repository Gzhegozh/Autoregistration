Feature: Automatic registration

  In order to automatic registrations of fake users
  A hacker
  Should be able to register 100 accounts

  Scenario: Automatic registration

    Given "100" fake accounts
    When hacker makes registration
    Then fake emails and passwords for "100" accounts placed in profiles.csv