const options = {
    baseElement: ['',
        ' on the tooltip',
        ' in the tooltip',
        ' on the role selector dropdown',
        ' in the role selector dropdown',
        ' on the dialog box',
        ' in the dialog box',
        ' within the data collection instrument list',
        ' on the action popup',
        ' in the action popup',
        ' in the "Main project settings" section',
        ' in the "Use surveys in this project?" row in the "Main project settings" section',
        ' in the "Use longitudinal data collection with defined events?" row in the "Main project settings" section',
        ' in the "Use the MyCap participant-facing mobile app?" row in the "Main project settings" section',
        ' in the "Enable optional modules and customizations" section',
        ' in the "Repeating instruments and events" row in the "Enable optional modules and customizations" section',
        ' in the "Auto-numbering for records" row in the "Enable optional modules and customizations" section',
        ' in the "Scheduling module (longitudinal only)" row in the "Enable optional modules and customizations" section',
        ' in the "Randomization module" row in the "Enable optional modules and customizations" section',
        ' in the "Designate an email field for communications (including survey invitations and alerts)" row in the "Enable optional modules and customizations" section',
        ' in the "Twilio SMS and Voice Call services for surveys and alerts" row in the "Enable optional modules and customizations" section',
        ' in the "SendGrid Template email services for Alerts & Notifications" row in the "Enable optional modules and customizations" section',
        ' in the validation row labeled "Code Postal 5 caracteres (France)"',
        ' in the validation row labeled "Date (D-M-Y)"',
        ' in the validation row labeled "Date (M-D-Y)"',
        ' in the validation row labeled "Date (Y-M-D)"',
        ' in the validation row labeled "Datetime (D-M-Y H:M)"',
        ' in the validation row labeled "Datetime (M-D-Y H:M)"',
        ' in the validation row labeled "Datetime (Y-M-D H:M)"',
        ' in the validation row labeled "Datetime w/ seconds (D-M-Y H:M:S)"',
        ' in the validation row labeled "Datetime w/ seconds (M-D-Y H:M:S)"',
        ' in the validation row labeled "Datetime w/ seconds (Y-M-D H:M:S)"',
        ' in the validation row labeled "Email"',
        ' in the validation row labeled "Integer"',
        ' in the validation row labeled "Letters only"',
        ' in the validation row labeled "MRN (10 digits)"',
        ' in the validation row labeled "MRN (generic)"',
        ' in the validation row labeled "Number"',
        ' in the validation row labeled "Number (1 decimal place - comma as decimal)"',
        ' in the validation row labeled "Number (1 decimal place)"',
        ' in the validation row labeled "Number (2 decimal places - comma as decimal)"',
        ' in the validation row labeled "Number (2 decimal places)"',
        ' in the validation row labeled "Number (3 decimal places - comma as decimal)"',
        ' in the validation row labeled "Number (3 decimal places)"',
        ' in the validation row labeled "Number (4 decimal places - comma as decimal)"',
        ' in the validation row labeled "Number (4 decimal places)"',
        ' in the validation row labeled "Number (comma as decimal)"',
        ' in the validation row labeled "Phone (Australia)"',
        ' in the validation row labeled "Phone (North America)"',
        ' in the validation row labeled "Phone (UK)"',
        ' in the validation row labeled "Postal Code (Australia)"',
        ' in the validation row labeled "Postal Code (Canada)"',
        ' in the validation row labeled "Postal Code (Germany)"',
        ' in the validation row labeled "Social Security Number (U.S.)"',
        ' in the validation row labeled "Time (HH:MM:SS)"',
        ' in the validation row labeled "Time (HH:MM)"',
        ' in the validation row labeled "Time (MM:SS)"',
        ' in the validation row labeled "Vanderbilt MRN"',
        ' in the validation row labeled "Zipcode (U.S.)"'],
    tableTypes :[
        'a',
        'logging',
        'browse users',
        'file repository',
        'administrators',
        'reports',
        'report data',
        'define events',
        'data access groups',
        'DAGs Switcher',
        'record status dashboard',
        'data collection instruments',
        'codebook'
    ],
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
        '',
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
        '',
        ' with Edit survey responses checked',
        ' with Edit survey responses unchecked',
        '',
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
        '',
        ' on the dialog box for the Repeatable Instruments and Events module',
        ' on the Designate Instruments for My Events page',
        ' on the Online Designer page',
        ' and cancel the confirmation window',
        ' and accept the confirmation window',
        ' in the dialog box to request a change in project status',
        ' to rename an instrument',
        ' in the "Add New Field" dialog box',
        ' in the "Edit Field" dialog box',
        '',
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
    userRightAction: ['add', 'remove'],
    ordinal: [
                'first',
                'second',
                'third',
                'fourth',
                'fifth',
                'sixth',
                'seventh',
                'eighth',
                'ninth',
                'last',
    ]
}

function countStringInstances(gherkinStep) {
    const regex = /\{string\}/g;
    const matches = gherkinStep.match(regex);
    return matches ? matches.length : 0;
}

function countIntInstances(gherkinStep) {
    const regex = /\{int\}/g;
    const matches = gherkinStep.match(regex);
    return matches ? matches.length : 0;
}

function extractOptionalText(text) {
    const optionalTextMatch = text.match(/\((.*?)\)/);
    return optionalTextMatch ? optionalTextMatch[1] : '';
}

function outputStepGenerator(index){
    const stepDefinition = window.all_steps[index - 1]

    // Function to replace placeholders with dropdowns and display in the output div
    const placeholders = stepDefinition.match(/\((.*?)\)/g) || [];

    let replacedStepDefinition = stepDefinition;
    let str_step = ''

    for(let i = 0; i < countStringInstances(replacedStepDefinition); i++) {
        let inputBox = `"<input type="text" id="string_${index}_Input${i}">"`
        str_step += replacedStepDefinition.split("{string}")[i] + inputBox
    }

    str_step += replacedStepDefinition.split("{string}")[countStringInstances(replacedStepDefinition)]
    replacedStepDefinition = str_step

    let int_step = ''

    for(let i = 0; i < countIntInstances(replacedStepDefinition); i++) {
        let intBox = `<input type="text" id="int_${index}_Input${i}">`
        int_step += replacedStepDefinition.split("{int}")[i] + intBox
    }

    int_step += replacedStepDefinition.split("{int}")[countIntInstances(replacedStepDefinition)]
    replacedStepDefinition = int_step

    for (let i = 0; i < Object.keys(placeholders).length; i++) {
        const param = placeholders[i]
        const optionalText = extractOptionalText(param);
        const dropdown = `<select id="optional_${index}_${i}"><option value=""> </option><option value="${optionalText}">${optionalText}</option></select>`
        replacedStepDefinition = replacedStepDefinition.replace(param, dropdown)
    }

    // Replace each placeholder with a dropdown menu
    for (let i = 0; i < Object.keys(options).length; i++) {
        let param = Object.keys(options)[i]
        const pattern = new RegExp(`\\{${param}\\}`, 'g');
        if(replacedStepDefinition.match(pattern)) {
            const dropdown = `<select id="${param}_${index}">${options[param].map(option => `<option value="${option}">${option}</option>`).join('')}</select>`;
            replacedStepDefinition = replacedStepDefinition.replace(`{${param}}`, dropdown)
        }
    }

    // Display the replaced step definition in the output div
    document.getElementById(`input${index}`).innerHTML = replacedStepDefinition
}

function generateText(index) {
    const stepDefinition = window.all_steps[index - 1]

    const placeholders = stepDefinition.match(/\((.*?)\)/g) || [];

    // Replace placeholders in the step definition with selected values and input field
    let selectedValues = {}
    let stringInput = {}
    let intInput = {}

    let replacedStepDefinition = stepDefinition

    let str_step = ''

    for(let i = 0; i < countStringInstances(stepDefinition); i++) {
        stringInput[i] = document.getElementById(`string_${index}_Input${i}`).value;
        str_step += `${replacedStepDefinition.split("{string}")[i]} "${stringInput[i]}"`
    }

    replacedStepDefinition = `${str_step} ${replacedStepDefinition.split("{string}")[countStringInstances(replacedStepDefinition)]}`

    let int_step = ''

    for(let i = 0; i < countIntInstances(stepDefinition); i++) {
        intInput[i] = document.getElementById(`int_${index}_Input${i}`).value;
        int_step += `${replacedStepDefinition.split("{int}")[i]} ${intInput[i]} `
    }

    replacedStepDefinition = `${int_step} ${replacedStepDefinition.split("{int}")[countIntInstances(replacedStepDefinition)]}`

    for (let i = 0; i < Object.keys(options).length; i++) {
        let param = Object.keys(options)[i]
        const pattern = new RegExp(`\\{${param}\\}`, 'g');
        if(replacedStepDefinition.match(pattern)) {
            let dropdown = document.getElementById(`${param}_${index}`);
            selectedValues[param] = dropdown.options[dropdown.selectedIndex].text;
            replacedStepDefinition = replacedStepDefinition.replace(`{${param}}`, selectedValues[param]);
        }
    }

    for(let i = 0; i < Object.keys(placeholders).length; i++) {
        const param = placeholders[i]
        const value = document.getElementById(`optional_${index}_${i}`).value
        replacedStepDefinition = replacedStepDefinition.replace(param, value)
    }

    // Display the replaced step definition in the output div
    document.getElementById(`output${index}`).innerHTML = `<strong>Generated Step:</strong><br />${replacedStepDefinition}`;
}