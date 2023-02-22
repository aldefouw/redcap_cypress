import { defineParameterType } from "cypress-cucumber-preprocessor/steps";
import { ordinal_to_int } from '../core/commands.js'

// This file contains definitions for custom parameter types used in step definitions.
// Parameter type definitions have been consolidated here for easier reference and to avoid duplication.
// This should also make it easier to identify when refactoring/merging is appropriate.
// Comments indicate where the parameter type is used.

// visibility.js
defineParameterType({
    name: 'LabeledElement',
    regexp: /button|link/
})

// data_import.js
defineParameterType({
    name: 'project_type',
    regexp: /Practice \/ Just for fun|Operational Support|Research|Quality Improvement|Other/
})

// project_setup.js
defineParameterType({
    name: 'toggleAction',
    regexp: /enable|disable/
})

// project_setup.js
defineParameterType({
    name: 'status',
    regexp: /enabled|disabled/
})

// project_setup.js
defineParameterType({
    name: 'repeatability',
    regexp: /enabled|disabled|modifiable/
})

// interactions.js, temp_109_steps.js
defineParameterType({
    name: 'ordinal',
    regexp: /(?:(first|second|third|fourth|fifth|sixth|seventh|eighth|last) )?/,
    transformer: ordinal_to_int
})

// interactions.js
defineParameterType({
    name: 'confirmation',
    regexp: /accept|cancel/
})

// reporting.js
defineParameterType({
    name: 'ordering',
    regexp: /ascending|descending/
})

// user_rights.js
defineParameterType({
    name: 'data_viewing_rights',
    regexp: /No Access|Read Only|View & Edit/
})

// taken from visibility.js, but was not used.
// Presumably, this was made obsolete by replacing the Cucumber expression "{see}" with "(should) see"
defineParameterType({
    name: 'see',
    regexp: /should see|see/
})

// visibility.js
defineParameterType({
    name: 'check',
    regexp: /checked|unchecked/
})

// design_forms.js
defineParameterType({
    name: 'addField',
    regexp: /(Add Field|Add Matrix of Fields|Import from Field Bank)/
})

// design_forms.js
defineParameterType({
    name: 'editField',
    regexp: /(Edit|Branching Logic|Copy|Move|Delete Field)/
})

// design_forms.js
defineParameterType({
    name: 'fieldType',
    regexp: /(Text Box|Notes Box|Drop-down List|Radio Buttons|Checkboxes|Yes - No|True - False|Signature|File Upload|Slider|Descriptive Text|Begin New Section)/
})