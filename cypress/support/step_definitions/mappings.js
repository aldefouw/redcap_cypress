window.tableMappings = {
    'a' :'table',
    'logging' : 'table.form_border',
    'browse users' : 'table#sponsorUsers-table',
    'file repository' : 'table#file-repository-table',
    'administrators' : 'table#admin-rights-table',
    'reports' : 'table#table-report_list',
    'report data' : ['div.dataTables_scrollHeadInner table', 'table#report_table'],
    'define events' : 'table#event_table',
    'data access groups' : 'table#table-dags_table',
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

//Make sure to keep the blank choice - we want to default to first option
window.elementChoices = {
    '' : 'div[role=dialog]:visible,html',
    ' on the tooltip' : 'div[class*=tooltip]:visible',
    ' in the tooltip' : 'div[class*=tooltip]:visible',
    ' on the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
    ' in the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
    ' on the dialog box' : 'div[role=dialog]:visible',
    ' in the dialog box' : 'div[role=dialog]:visible',
    ' within the data collection instrument list' : 'table#table-forms_surveys',
    ' on the action popup' : '[id=formActionDropdown]',
    ' in the action popup' : '[id=formActionDropdown]',
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