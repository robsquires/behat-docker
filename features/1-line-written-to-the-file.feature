Feature: 1 line is written to the file

    Scenario: File should persist 1 line of random text
         When I write the 1 line of random text to the file
         Then the file should contain 1 line

    Scenario: File should persist 12 line of random text
         When I write the 12 line of random text to the file
         Then the file should contain 12 line

    Scenario: File should persist 13 lines of random text
         When I write the 13 line of random text to the file
         Then the file should contain 13 line

    Scenario: File should persist 14 lines of random text
         When I write the 14 line of random text to the file
         Then the file should contain 14 line