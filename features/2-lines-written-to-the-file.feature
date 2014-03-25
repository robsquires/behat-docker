Feature: 2 lines are written to the file

    Scenario: File should persist 2 lines of random text
         When I write the 2 lines of random text to the file
         Then the file should contain 2 lines

    Scenario: File should persist 22 lines of random text
         When I write the 22 line of random text to the file
         Then the file should contain 22 line

    Scenario: File should persist 23 lines of random text
         When I write the 23 line of random text to the file
         Then the file should contain 23 line

    Scenario: File should persist 24 lines of random text
         When I write the 24 line of random text to the file
         Then the file should contain 24 line