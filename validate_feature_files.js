// validate-feature-files.js
const fs = require('fs');
const path = require('path');
const parser = require("gherkin-parse");
const Glob = require('glob-fs');

// Create a glob-fs instance
const glob = Glob({ cwd: __dirname }); // Set the current working directory

// Define your base directory for globbing
const BASE_DIR = path.join(__dirname, 'redcap_rsvc'); // Base directory path
const GLOB_PATTERN = '**/*.feature'; // Glob pattern for .feature files

// Function to validate a single feature file
function validateFeatureFile(filePath) {
    try {
        parser.convertFeatureFileToJSON(filePath)
    } catch (error) {
        return false
    }

    return true
}

// Debugging: Log the start of glob search
//console.log('Starting glob search with pattern:', GLOB_PATTERN);

// Find all feature files matching the glob pattern
const files = glob.readdirSync(`${GLOB_PATTERN}`, { cwd: BASE_DIR });

// Debugging: Log the files found
//console.log('Found feature files:', files);

// Check if any files were found
if (files.length === 0) {
    console.log('No .feature files found matching the pattern.');
} else {
    // Validate each found feature file
    const failedFiles = []
    files.forEach(file => {
        const filePath = path.join(BASE_DIR, file); // Get full file path
        if (!validateFeatureFile(filePath)) {
            failedFiles.push(filePath)
        }
    });

    if (failedFiles.length !== 0) {
        failedFiles.forEach(filePath => {
            console.error(`${filePath} is invalid - contains PARSE ERRORS.`);
        });

        process.exit(1) // Exit with non-zero code so run.sh stops
    }
}