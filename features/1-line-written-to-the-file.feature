Feature: 1 line is written to the file

    Scenario: File should persist 1 line of random text
         When I write the 1 line of random text to the file
         Then the file should contain 1 line

    Scenario: File should persist 11 lines of random text
         When I write the 11 line of random text to the file
         Then the file should contain 11 line