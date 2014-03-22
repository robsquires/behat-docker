<?php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
class FeatureContext extends BehatContext
{

    private $file = '/tmp/app-data.txt';

    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
        // 
    }

    /**
     *
     */
    public function removeFile()
    {
        $file = $this->file;

        exec("rm $file");
        sleep(2);
    }

    /**
     * @When /^I write the (\d+) lines? of random text to the file$/
     */
    public function iWriteTheLineOfRandomTextToTheFile($lines)
    {
        $this->removeFile();

        $file = $this->file;

        for($i=0; $i < $lines; $i++){
            $text = $this->getRandString();
            exec("echo $text >> $file");
        }

        
    }

    /**
     * @Then /^the file should contain (\d+) lines?$/
     */
    public function theFileShouldContainLine($desiredLines)
    {
        $file = $this->file;

        $lines = exec("cat $file | wc -l");

        if($lines != $desiredLines){
            throw new \Exception(
                printf(
                    'Expected %d lines, found %d',
                    $desiredLines,
                    $lines
                )
            );
        }
    }


    private function getRandString()
    {
        return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"), 0, 32);

    }
}
