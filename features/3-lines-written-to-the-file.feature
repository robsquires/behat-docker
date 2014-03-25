Feature: 3 lines are written to the file

    Scenario: File should persist 3 lines of random text
         When I write the 3 lines of random text to the file
         Then the file should contain 3 lines

    Scenario: File should persist 32 lines of random text
         When I write the 32 line of random text to the file
         Then the file should contain 32 line

    Scenario: File should persist 33 lines of random text
         When I write the 33 line of random text to the file
         Then the file should contain 33 line

    Scenario: File should persist 34 lines of random text
         When I write the 34 line of random text to the file
         Then the file should contain 34 line