Feature: 4 lines are written to the file

    Scenario: File should persist 4 lines of random text
         When I write the 4 lines of random text to the file
         Then the file should contain 4 lines

    Scenario: File should persist 44 lines of random text
         When I write the 44 line of random text to the file
         Then the file should contain 44 line