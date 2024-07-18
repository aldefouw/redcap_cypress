// This file contains definitions for custom parameter types used in step definitions.
// Parameter type definitions have been consolidated here for easier reference and to avoid duplication.
// This should also make it easier to identify when refactoring/merging is appropriate.
// Comments indicate where the parameter type is used.

function transformToRegExp(keys){
    const escapedKeys = keys.map(key => key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
    return new RegExp(`|${escapedKeys.join('|')}`)
}

defineParameterType({
    name: 'ordinal',
    regexp: /(?: (first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|last||))?/,
})

for (const key in window.parameterTypes) {
    defineParameterType({
        name: key,
        regexp: transformToRegExp(window.parameterTypes[key]),
    })
}
window.userRightChecks = {
    'Project Setup & Design' : 'design',
    'User Rights' : 'user_rights',
    'Data Access Groups' : 'data_access_groups',
    'Stats & Charts' : 'graphical',
    'Create Records' : 'record_create',
    'Survey Distribution Tools' : 'participants',
    'Add/Edit/Organize Reports': 'reports',
    'Alerts & Notifications' : 'alerts',
    'Rename Records' : 'record_rename',
    'Delete Records' : 'record_delete',
    'Calendar' : 'calendar',
    'Data Import Tool'  : 'data_import_tool',
    'Data Comparison Tool' : 'data_comparison_tool',
    'Logging'  : 'data_logging',
    'File Repository' : 'file_repository',
    'Record Locking Customization' : 'lock_record_customize',
    'Lock/Unlock *Entire* Records' : 'lock_record_multiform',
    'Lock/Unlock *Entire* Records (record level)' : 'lock_record_multiform',
    'Data Quality - Create & edit rules' : 'data_quality_design',
    'Data Quality - Execute rules' : 'data_quality_execute',
    'API Export' : 'api_export',
    'API Import/Update' : 'api_import',
    'REDCap Mobile App - Allow users to collect data offline in the mobile app' : 'mobile_app',
    'REDCap Mobile App - Allow user to download data for all records to the app?' : 'mobile_app_download_data'
}

window.singleChoiceMappings = {
    'Data Exports' : 'data_export_tool',
    'API' : 'data_access_groups',
    'Lock/Unlock Records' : 'lock_record'
}

//These apply to REDCap v12+
window.dataExportMappings = {
    'No Access' : '0',
    'De-Identified' : '2',
    'Remove All Identifier Fields' : '3',
    'Full Data Set' : '1'
}

window.tableMappings = {
    'a' :'table',
    'logging' : 'table.form_border',
    'browse users' : 'table#sponsorUsers-table',
    'file repository' : 'table#file-repository-table',
    'administrators' : 'table#admin-rights-table',
    'reports' : 'table#table-report_list',
    'report data' : ['div.dataTables_scrollHeadInner table', 'table#report_table'],
    'define events' : 'table#event_table',
    'data access groups' : ['div#dags_table table:first', 'div#dags_table table#table-dags_table'],
    'DAGs Switcher' : 'div#dag-switcher-config-container-parent table',
    'record status dashboard': 'table#record_status_table',
    'data collection instruments': 'table#table-forms_surveys',
    'codebook' : 'table#codebook-table'
}

window.dateFormats = {
    'mm-dd-yyyy': /\d{2}-\d{2}-\d{4}/,
    'yyyy-mm-dd': /\d{4}-\d{2}-\d{2}/,
    'mm-dd-yyyy hh:mm': /\d{2}-\d{2}-\d{4} \d{1,2}:\d{2}(?:am|pm)/,
    'yyyy-mm-dd hh:mm': /\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}(?:am|pm)/,
    'mm-dd-yyyy hh:mm:ss': /\d{2}-\d{2}-\d{4} \d{1,2}:\d{2}:\d{2}(?:am|pm)/,
    'yyyy-mm-dd hh:mm:ss': /\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}:\d{2}(?:am|pm)/,
    'mm/dd/yyyy': /\d{2}\/\d{2}\/\d{4}/,
    'yyyy/mm/dd': /\d{4}\/\d{2}\/\d{2}/,
    'mm/dd/yyyy hh:mm': /\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(?:am|pm)/,
    'yyyy/mm/dd hh:mm': /\d{4}\/\d{2}\/\d{2} \d{1,2}:\d{2}(?:am|pm)/,
    'mm/dd/yyyy hh:mm:ss': /\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}:\d{2}(?:am|pm)/,
    'yyyy/mm/dd hh:mm:ss': /\d{4}\/\d{2}\/\d{2} \d{1,2}:\d{2}:\d{2}(?:am|pm)/,
    'hh:mm': /\d{1,2}:\d{2}(?:am|pm)/,
    'hh:mm:ss': /\d{1,2}:\d{2}:\d{2}(?:am|pm)/,
    'hh:mm:ss.ms': /\d{1,2}:\d{2}:\d{2}\.\d{3}(?:am|pm)/,
}

window.exportMappings = {
    'CSV / Microsoft Excel (raw data)'  :    'csv',
    'CSV / Microsoft Excel (labels)'    :    'csv',
    'SPSS Statistical Software'         :    'sps',
    'SAS Statistical Software'          :    'sas',
    'R Statistical Software'            :    'r',
    'Stata Statistical Software'        :    'do',
    'CDISC ODM (XML)'                   :    'odm'
}

window.validationTypes = {
    'Code Postal 5 caracteres (France)'             : 'postalcode_french',
    'Date (D-M-Y)'                                  : 'date_dmy',
    'Date (M-D-Y)'                                  : 'date_mdy',
    'Date (Y-M-D)'                                  : 'date_ymd',
    'Datetime (D-M-Y H:M)'                          : 'datetime_dmy',
    'Datetime (M-D-Y H:M)'                          : 'datetime_mdy',
    'Datetime (Y-M-D H:M)'                          : 'datetime_ymd',
    'Datetime w/ seconds (D-M-Y H:M:S)'             : 'datetime_seconds_dmy',
    'Datetime w/ seconds (M-D-Y H:M:S)'             : 'datetime_seconds_mdy',
    'Datetime w/ seconds (Y-M-D H:M:S)'             : 'datetime_seconds_ymd',
    'Email'                                         : 'email',
    'Integer'                                       : 'integer',
    'Letters only'                                  : 'alpha_only',
    'MRN (10 digits)'                               : 'mrn_10d',
    'MRN (generic)'                                 : 'mrn_generic',
    'Number'                                        : 'number',
    'Number (1 decimal place - comma as decimal)'   : 'number_1dp_comma_decimal',
    'Number (1 decimal place)'                      : 'number_1dp',
    'Number (2 decimal places - comma as decimal)'  : 'number_2dp_comma_decimal',
    'Number (2 decimal places)'                     : 'number_2dp',
    'Number (3 decimal places - comma as decimal)'  : 'number_3dp_comma_decimal',
    'Number (3 decimal places)'                     : 'number_3dp',
    'Number (4 decimal places - comma as decimal)'  : 'number_4dp_comma_decimal',
    'Number (4 decimal places)'                     : 'number_4dp',
    'Number (comma as decimal)'                     : 'number_comma_decimal',
    'Phone (Australia)'                             : 'phone_australia',
    'Phone (North America)'                         : 'phone',
    'Phone (UK)'                                    : 'phone_uk',
    'Postal Code (Australia)'                       : 'postalcode_australia',
    'Postal Code (Canada)'                          : 'postalcode_canada',
    'Postal Code (Germany)'                         : 'postalcode_germany',
    'Social Security Number (U.S.)'                 : 'ssn',
    'Time (HH:MM:SS)'                               : 'time_hh_mm_ss',
    'Time (HH:MM)'                                  : 'time',
    'Time (MM:SS)'                                  : 'time_mm_ss',
    'Vanderbilt MRN'                                : 'vmrn',
    'Zipcode (U.S.)'                                : 'zipcode',
}

window.projectModules = {
    'Main project settings': [
                              'Use surveys in this project?',
                              'Use longitudinal data collection with defined events?',
                              'Use the MyCap participant-facing mobile app?'
                             ],

    'Enable optional modules and customizations' : [
                                                     'Repeating instruments and events',
                                                     'Auto-numbering for records',
                                                     'Scheduling module (longitudinal only)',
                                                     'Randomization module',
                                                     'Designate an email field for communications (including survey invitations and alerts)',
                                                     'Twilio SMS and Voice Call services for surveys and alerts',
                                                     'SendGrid Template email services for Alerts & Notifications'
                                                    ]
}

//Make sure to keep the blank choice - we want to default to first option
window.elementChoices = {
    '' : 'html',
    ' on the tooltip' : 'div[class*=tooltip]:visible',
    ' in the tooltip' : 'div[class*=tooltip]:visible',
    ' on the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
    ' in the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
    ' on the dialog box' : 'div[role=dialog]:visible',
    ' in the dialog box' : 'div[role=dialog]:visible',
    ' within the data collection instrument list' : 'table#table-forms_surveys',
    ' on the action popup' : '[id=formActionDropdown]',
    ' in the action popup' : '[id=formActionDropdown]',
    ' in the View Access section of User Access' : 'td[class=labelrc]:contains("View Access")',
    ' in the Edit Access section of User Access' : 'td[class=labelrc]:contains("Edit Access")',
    ' in the Lock Record Custom Text'
}

//IMPORTANT: Programmatically add the projectModules as element choices
for (const category in window.projectModules) {
    if (window.projectModules.hasOwnProperty(category)) {
        window.elementChoices[` in the "${category}" section`] = `div:contains("${category}"):visible`

        window.projectModules[category].forEach((element) => {
            window.elementChoices[` in the "${element}" row in the "${category}" section`] = `div:contains("${element}"):visible`
        })
    }
}

window.icons = {
    'disabled icon'      : `img[src*=delete]:visible`,
    'checkmark icon'     : `img[src*=tick]:visible`,
    'x icon'             : `img[src*=cross]:visible`
}

//IMPORTANT: Programmatically add the validationTypes as element choices
for (const validation_desc in window.validationTypes) {
    window.elementChoices[` in the validation row labeled "${validation_desc}"`] = `tr[id=${window.validationTypes[validation_desc]}]`
}

window.ordinalChoices = {
    first: 0,
    second: 1,
    third: 2,
    fourth: 3,
    fifth: 4,
    sixth: 5,
    seventh: 6,
    eighth: 7,
    ninth: 8,
    last: -1
}

window.toDoListTables = {
    'Pending Requests' : 'pending-container',
    'Low Priority Pending Requests' : 'complete-ignore-container',
    'Completed & Archived Requests' : 'archived-container',
}
function transformKeysToRegExp(variable){
    return Object.keys(variable).filter(key => key !== '')
}

window.parameterTypes = {
    tableTypes: transformKeysToRegExp(window.tableMappings),
    baseElement: transformKeysToRegExp(window.elementChoices),
    toDoTableTypes: transformKeysToRegExp(window.toDoListTables),
    userRightsChecks: transformKeysToRegExp(window.userRightChecks),
    addEditField: ['Add New Field', 'Edit Field'],
    addField: ['Add Field', 'Add Matrix of Fields', 'Import from Field Bank'],
    addOrSelect: ['add', 'select'],
    beforeAfter: ['before', 'after'],
    cellAction: [
        ' and click the new instance link',
        ' and click on the bubble',
        ' and click the repeating instrument bubble for the first instance',
        ' and click the repeating instrument bubble for the second instance',
        ' and click the repeating instrument bubble for the third instance',
    ],
    check: ['checked', 'unchecked'],
    checkBoxRadio: ['checkbox', 'radio'],
    clickType: ['click on', 'check', 'uncheck'],
    confirmation: ['accept', 'cancel'],
    dataViewingRights: ['No Access', 'Read Only', 'View & Edit', 'Edit survey responses'],
    dropdownType: ['dropdown', 'multiselect'],
    editEvent: ['Edit', 'Delete'],
    editField: ['Edit', 'Branching Logic', 'Copy', 'Move', 'Delete Field'],
    editSurveyRights: [
        ' with Edit survey responses checked',
        ' with Edit survey responses unchecked',
    ],
    enableDisable: ['enable', 'disable'],
    elmType: ['input', 'list item', 'checkbox', 'span'],
    enterType: ['verify', 'enter', 'clear field and enter'],
    fieldType: [
        'Text Box',
        'Notes Box',
        'Drop-down List',
        'Radio Buttons',
        'Checkboxes',
        'Yes - No',
        'True - False',
        'Signature',
        'File Upload',
        'Slider',
        'Descriptive Text',
        'Begin New Section',
        'Calculated Field',
    ],
    headerOrNot: ['header and '],
    iframeVisibility: ['', ' in the iframe'],
    inputType: ['input', 'password'],
    instrumentSaveOptions: [
        'Save & Stay',
        'Save & Exit Record',
        'Save & Go To Next Record',
        'Save & Exit Form',
        'Save & Go To Next Form',
        'Save & Go To Next Instance',
        'Save & Add New Instance',
    ],
    labeledElement: ['button', 'link'],
    labeledExactly: ['labeled', 'labeled exactly'],
    linkNames: ['link', 'tab', 'instrument'],
    projectRequestLabel: ['Create Project', 'Send Request'],
    notSee: ['not '],
    ordering: ['ascending', 'descending'],
    projectStatus: ['Production', 'Development', 'Analysis/Cleanup'],
    projectType: [
        'Practice / Just for fun',
        'Operational Support',
        'Research',
        'Quality Improvement',
        'Other',
    ],
    recordIDEvent: ['record ID', 'event'],
    repeatability: ['enabled', 'disabled', 'modifiable', 'unchangeable'],
    saveButtonRouteMonitoring: [
        ' on the dialog box for the Repeatable Instruments and Events module',
        ' on the Designate Instruments for My Events page',
        ' on the Online Designer page',
        ' and cancel the confirmation window',
        ' and accept the confirmation window',
        ' in the dialog box to request a change in project status',
        ' to rename an instrument',
        ' in the "Add New Field" dialog box',
        ' in the "Edit Field" dialog box'
    ],
    select: ['selected', 'unselected'],
    tableName: ['', ' of the User Rights table', ' of the Reports table'],
    timeType: ['seconds', 'second', 'minutes', 'minute'],
    toDoRequestTypes: ['Move to prod', 'Approve draft changes', 'Copy project'],
    toDoTableIcons: [
        'process request',
        'get more information',
        'add or edit a comment',
        'Move to low priority section',
        'archive request notification',
    ],
    toDownloadFile: [' to download a file'],
    userRightAction: ['add', 'remove']
}