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
    'report data' : ['table.dataTable', 'table#report_table'],
    'define events' : 'table#event_table',
    'data access groups' : ['div#dags_table table:first', 'div#dags_table table#table-dags_table'],
    'DAGs Switcher' : 'div#dag-switcher-config-container-parent table',
    'record status dashboard': 'table#record_status_table',
    'data collection instruments': 'table#table-forms_surveys',
    'codebook' : 'table#codebook-table',
    'import data display' : 'table#comptable',
    'participant list' : ['div#partlist_outerdiv table', 'table#table-participant_table'],
    'user rights' : ['div#user_rights_roles_table table', 'table#table-user_rights_roles_table'], 
    'record locking' : 'table#part11_forms',
    'e-signature and locking management' : 'table#esignLockList',
    'record home page': 'table#event_grid_table'
}

window.dateFormats = {
    'mm-dd-yyyy': /\d{2}-\d{2}-\d{4}/,
    'yyyy-mm-dd': /\d{4}-\d{2}-\d{2}/,
    'mm-dd-yyyy hh:mm': /\d{2}-\d{2}-\d{4} \d{1,2}:\d{2}(?:am|pm)?/,
    'yyyy-mm-dd hh:mm': /\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}(?:am|pm)?/,
    'mm-dd-yyyy hh:mm:ss': /\d{2}-\d{2}-\d{4} \d{1,2}:\d{2}:\d{2}(?:am|pm)?/,
    'yyyy-mm-dd hh:mm:ss': /\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}:\d{2}(?:am|pm)?/,
    'mm/dd/yyyy': /\d{2}\/\d{2}\/\d{4}/,
    'yyyy/mm/dd': /\d{4}\/\d{2}\/\d{2}/,
    'mm/dd/yyyy hh:mm': /\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(?:am|pm)?/,
    'yyyy/mm/dd hh:mm': /\d{4}\/\d{2}\/\d{2} \d{1,2}:\d{2}(?:am|pm)?/,
    'mm/dd/yyyy hh:mm:ss': /\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}:\d{2}(?:am|pm)?/,
    'yyyy/mm/dd hh:mm:ss': /\d{4}\/\d{2}\/\d{2} \d{1,2}:\d{2}:\d{2}(?:am|pm)?/,
    'hh:mm': /\d{1,2}:\d{2}(?:am|pm)?/,
    'hh:mm:ss': /\d{1,2}:\d{2}:\d{2}(?:am|pm)?/,
    'hh:mm:ss.ms': /\d{1,2}:\d{2}:\d{2}\.\d{3}(?:am|pm)?/
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
    ' on the Add/Edit Branching Logic dialog box' : 'div[role=dialog]:visible',
    ' in the Add/Edit Branching Logic dialog box' : 'div[role=dialog]:visible',
    ' within the data collection instrument list' : 'table#table-forms_surveys',
    ' on the action popup' : '[id=formActionDropdown]',
    ' in the action popup' : '[id=formActionDropdown]',
    ' in the Edit survey responses column' : 'table#form_rights:visible',
    ' in the open date picker widget' : 'div.ui-datepicker',
    ' in the File Repository breadcrumb' : '#file-repository-table-parent:visible',
    ' in the File Repository table' : '#file-repository-table:visible',
    ' in the View Access section of User Access' : 'td[class=labelrc]:contains("View Access")',
    ' in the Edit Access section of User Access' : 'td[class=labelrc]:contains("Edit Access")'
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
    'enabled survey icon'   : 'img[src*=tick_shield]:visible',
    'disabled icon'         : `img[src*=delete]:visible`,
    'checkmark icon'        : `img[src*=tick]:visible`,
    'x icon'                : `img[src*=cross]:visible`
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
    tenth: 9,
    eleventh: 10,
    twelfth: 11,
    thirteenth: 12,
    fourteenth: 13,
    fifteenth: 14,
    sixteenth: 15,
    seventeenth: 16,
    eighteenth: 17,
    nineteenth: 18,
    twentieth: 19,
    last: -1
}

window.toDoListTables = {
    'Pending Requests': 'pending-container',
    'Low Priority Pending Requests': 'complete-ignore-container',
    'Completed & Archived Requests': 'archived-container',
}

window.recordStatusIcons = {
    'Incomplete' : `img[src*=circle_red]`,
    'Unverified' : `img[src*=circle_yellow]`,
    'Complete' : `img[src*=circle_green]`,
    'Many statuses (mixed)' : `img[src*=circle_blue_stack]`,
    'Incomplete (no data saved)' : `img[src*=circle_gray]`,
    'Partial Survey Response' : `img[src*=circle_orange_tick]`,
    'Completed Survey Response' : `img[src*=circle_green_tick]`,
    'Many statuses (all same)' : `img[src*=_stack]`
}

window.fileRepoIcons = {
    'File Share' : `i[class*=fa-arrow-up]`,
    'Restore' : `i[class*=fa-file-circle-plus]`,
    'Delete' : `i[class*=fa-times]`,
    'Delete Permanently' : `i[class*=fa-trash-can]`
}

window.onlineDesignerFieldIcons = {
    'Edit' : `img[src*=pencil]`,
    'Branching Logic': `img[src*=branch]`,
    'Copy' : `img[src*=copy]`,
    'Move' : `img[src*=move]`,
    'Stop' : 'img[src*=stop]',
    'Delete Field': `img[src*=cross]`,
    'Delete': `img[src*=cross]`,
    '"view"' : 'a:visible:contains(view)',
    '"export"' : 'a:visible:contains(export)',
    '"exclude"' : 'a:visible:contains(exclude)',
    '"remove exclusion"' : 'a:visible:contains(remove exclusion)'
}

window.participantListIcons = {
    'green checkmark' : `img[src*=circle_green_tick]`,
    'gray bubble': `img[src*=stop_gray]`
}

window.tableHtmlElements = {
    '[icon]': { selector: 'img', condition: 'exist'},
    '[button]': { selector: 'button,input[type=button]', condition: 'exist'},
    '[✓]': { selector: 'input[type=checkbox]:checked', condition: 'be.checked'},
    '[ ]': { selector: 'input[type=checkbox]', condition: 'not.be.checked'},
    '[text box]': { selector: 'textarea', condition: 'exist'},
    '[lock icon]': { selector: 'img[src*=lock]', condition: 'exist' },
    '[e-signed icon]': { selector: 'img[src*=shield]', condition: 'exist' }
}