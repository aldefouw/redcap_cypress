const { Given, defineParameterType } = require('@badeball/cypress-cucumber-preprocessor')
const { rctf_initialize} = require ('rctf')

rctf_initialize(Given, defineParameterType)