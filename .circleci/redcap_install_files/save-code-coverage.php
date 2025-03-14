<?php
declare(strict_types=1);

//Only run this if we're being run through apache interface
$sapi_name = php_sapi_name();
if (strpos($sapi_name, 'apache') !== 0) {
    return;
}

// Get the filename being executed
$filename = $_SERVER['SCRIPT_FILENAME'];

// Get the current REDCap version
$redcap_version = getenv('REDCAP_VERSION');
require 'redcap_v'.$redcap_version.'/vendor/autoload.php';

use SebastianBergmann\CodeCoverage\Filter;
use SebastianBergmann\CodeCoverage\Driver\Selector;
use SebastianBergmann\CodeCoverage\CodeCoverage;
use SebastianBergmann\CodeCoverage\Report\PHP as PhpReport;

$filter = new Filter;
$filter->includeFile($filename);
$coverage = new CodeCoverage(
    (new Selector)->forLineCoverage($filter),
    $filter
);

$coverage->start($_SERVER['REQUEST_URI']);


function save_coverage()
{
    global $coverage;
    $coverage->stop();
    (new PhpReport)->process($coverage, '/tmp/path/coverage/' . bin2hex(random_bytes(16)) . '.cov');
}

register_shutdown_function('save_coverage');
?>
