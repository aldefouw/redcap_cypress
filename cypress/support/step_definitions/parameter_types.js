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

//control_center.js
defineParameterType({
    name: 'toggle',
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
    regexp: /enabled|disabled|modifiable|unchangeable/
})

// project_setup.js
defineParameterType({
    name: 'repeatability_click',
    regexp: /enable|disable|modify/
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
    regexp: /No Access|Read Only|View & Edit|Edit survey responses/
})

// user_rights.js
defineParameterType({
    name: 'edit_survey_rights',
    regexp: /| with Edit survey responses checked| with Edit survey responses unchecked||/
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

defineParameterType({
    name: 'add_or_select',
    regexp: /add|select/
})

defineParameterType({
    name: 'user_right_action',
    regexp: /add|remove/
})

// design_forms.js
defineParameterType({
    name: 'editField',
    regexp: /(Edit|Branching Logic|Copy|Move|Delete Field)/
})

// longitudinal_events.js
defineParameterType({
    name: 'editEvent',
    regexp: /(Edit|Delete)/
})

// design_forms.js
defineParameterType({
    name: 'fieldType',
    regexp: /(Text Box|Notes Box|Drop-down List|Radio Buttons|Checkboxes|Yes - No|True - False|Signature|File Upload|Slider|Descriptive Text|Begin New Section|Calculated Field)/
})

defineParameterType({
    name: 'cell_action',
    regexp: / and click the new instance link| and click on the bubble| and click the repeating instrument bubble for the first instance| and click the repeating instrument bubble for the second instance| and click the repeating instrument bubble for the third instance||/
})

//visibility.js
defineParameterType({
    name: 'select',
    regexp: /selected|unselected/
})

//interactions.js
defineParameterType({
    name: 'instrument_save_options',
    regexp: /Save & Stay|Save & Exit Record|Save & Go To Next Record|Save & Exit Form|Save & Go To Next Form|Save & Go To Next Instance|Save & Add New Instance/
})

//interactions.js
defineParameterType({
    name: 'enter_type',
    regexp: /verify|enter|clear field and enter/
})

//interactions.js
defineParameterType({
    name: 'element_type',
    regexp: /element|checkbox/
})

//interactions.js
defineParameterType({
    name: 'click_type',
    regexp: /click on|check|uncheck/
})

//interactions.js
defineParameterType({
    name: 'elm_type',
    regexp: /input|list item|checkbox|span/
})

//interactions.js
defineParameterType({
    name: 'dropdown_type',
    regexp: /dropdown|multiselect/
})

defineParameterType({
    name: 'labeledExactly',
    regexp: /labeled|labeled exactly/
})

defineParameterType({
    name: 'saveButtonRouteMonitoring',
    regexp: /| on the dialog box for the Repeatable Instruments and Events module| on the Designate Instruments for My Events page| on the Online Designer page| and cancel the confirmation window| and accept the confirmation window| in the dialog box to request a change in project status/
})

defineParameterType({
    name: 'tableName',
    regexp: /| of the User Rights table| of the Reports table/
})

defineParameterType({
    name: 'linkNames',
    regexp: /link|tab/
})

defineParameterType({
    name: 'tableTypes',
    regexp: /|a|logging|browse users|file repository|administrators|reports|report data|define events|data access groups|DAGs Switcher|record status dashboard|/
})

defineParameterType({
    name: 'toDoTableTypes',
    regexp: /Pending Requests|Low Priority Pending Requests|Completed & Achived Requests/
})

defineParameterType({
    name: 'toDoRequestTypes',
    regexp: /Move to prod|Approve draft changes|Copy project/
})

defineParameterType({
    name: 'toDoTableIcons',
    regexp: /process request|get more information|add or edit a comment|Move to low priority section|archive request notification/
})

defineParameterType({
    name: 'iframeVisibility',
    regexp: /| in the iframe/
})

defineParameterType({
    name: 'baseElement',
    regexp: /| on the tooltip| on the dialog box| on the role selector dropdown| on the popup| in the tooltip| in the dialog box| in the role selector dropdown| in the popup/
})

defineParameterType({
    name: 'projectStatus',
    regexp: /|Production|Development/
})

defineParameterType({
    name: 'moveToProductionButton',
    regexp: /|Create Project|Send Request/
})

defineParameterType({
    name: 'checkBoxRadio',
    regexp: /|checkbox|radio/
})

defineParameterType({
    name: 'notSee',
    regexp: /||not /
})

defineParameterType({
    name: 'headerOrNot',
    regexp: /||header and |/
})