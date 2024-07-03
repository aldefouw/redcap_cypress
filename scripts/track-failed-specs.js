const fs = require('fs')

const resultsDir = 'cypress/results'
const failedSpecsPath = 'failed_specs.json'

function writeFailedSpecs(results) {
    const failedSpecs = results.runs
        .filter(run => run.stats.failures > 0)
        .map(run => run.spec.name)

    fs.writeFileSync(failedSpecsPath, JSON.stringify(failedSpecs))
}

function readFailedSpecs() {
    if (!fs.existsSync(failedSpecsPath)) {
        return []
    }
    return JSON.parse(fs.readFileSync(failedSpecsPath))
}

if (process.argv[2] === 'write') {
    const results = JSON.parse(fs.readFileSync(`${resultsDir}/mochawesome.json`))
    writeFailedSpecs(results)
} else if (process.argv[2] === 'read') {
    const failedSpecs = readFailedSpecs()
    console.log(failedSpecs.join(','))
}