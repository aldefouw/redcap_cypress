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
        let inputBox = `"<input type="text" id="string_Input_${i}_${index}">"`
        str_step += replacedStepDefinition.split("{string}")[i] + inputBox
    }

    str_step += replacedStepDefinition.split("{string}")[countStringInstances(replacedStepDefinition)]
    replacedStepDefinition = str_step

    let int_step = ''

    for(let i = 0; i < countIntInstances(replacedStepDefinition); i++) {
        let intBox = `<input type="text" oninput="validateInteger(this)" id="int_Input_${i}_${index}"><span class="error-message" id="error_message_${i}_${index}"></span>`
        int_step += replacedStepDefinition.split("{int}")[i] + intBox
    }

    int_step += replacedStepDefinition.split("{int}")[countIntInstances(replacedStepDefinition)]
    replacedStepDefinition = int_step

    for (let i = 0; i < Object.keys(placeholders).length; i++) {
        const param = placeholders[i]
        const optionalText = extractOptionalText(param);
        const dropdown = `<select class="select2" id="optional_${index}_${i}"><option value="">&nbsp;</option><option value="${optionalText}">${optionalText}</option></select>`
        replacedStepDefinition = replacedStepDefinition.replace(param, dropdown)
    }

    // Replace each placeholder with a dropdown menu
    for (let i = 0; i < Object.keys(window.parameterTypes).length; i++) {
        let param = Object.keys(window.parameterTypes)[i]
        const pattern = new RegExp(`\\{${param}\\}`, 'g');
        if(replacedStepDefinition.match(pattern)) {
            const dropdown = `<select class="select2" id="${param}_${index}"><option value="">&nbsp;</option>${window.parameterTypes[param].map(option => `<option value="${option}">${option}</option>`).join('')}</select>`;
            replacedStepDefinition = replacedStepDefinition.replace(`{${param}}`, dropdown)
        }
    }

    // Display the replaced step definition in the output div
    document.getElementById(`input${index}`).innerHTML = `<div class="step"><strong>Gherkin Generator:</strong><br />${replacedStepDefinition}</div>`
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
        stringInput[i] = document.getElementById(`string_Input_${i}_${index}`).value;
        str_step += `${replacedStepDefinition.split("{string}")[i]} "${stringInput[i]}"`
    }

    replacedStepDefinition = `${str_step} ${replacedStepDefinition.split("{string}")[countStringInstances(replacedStepDefinition)]}`

    let int_step = ''

    for(let i = 0; i < countIntInstances(stepDefinition); i++) {
        intInput[i] = document.getElementById(`int_Input_${i}_${index}`).value;
        int_step += `${replacedStepDefinition.split("{int}")[i]} ${intInput[i]} `
    }

    replacedStepDefinition = `${int_step} ${replacedStepDefinition.split("{int}")[countIntInstances(replacedStepDefinition)]}`

    for (let i = 0; i < Object.keys(window.parameterTypes).length; i++) {
        let param = Object.keys(window.parameterTypes)[i]
        const pattern = new RegExp(`\\{${param}\\}`, 'g');
        if(replacedStepDefinition.match(pattern)) {
            let dropdown = document.getElementById(`${param}_${index}`);
            selectedValues[param] = dropdown.options[dropdown.selectedIndex].text;
            if(dropdown.options[dropdown.selectedIndex].value === ""){
                replacedStepDefinition = replacedStepDefinition.replace(`{${param}}`, '')
            } else {
                replacedStepDefinition = replacedStepDefinition.replace(`{${param}}`, selectedValues[param])
            }

        }
    }

    for(let i = 0; i < Object.keys(placeholders).length; i++) {
        const param = placeholders[i]
        const value = document.getElementById(`optional_${index}_${i}`).value
        replacedStepDefinition = replacedStepDefinition.replace(param, value)
    }

    // Display the replaced step definition in the output div
    document.getElementById(`output${index}`).innerHTML = `<div class="generated_step"><strong>Generated Step:</strong><br /><button class="btn" style="background: #007bff" onclick="copyToClipboard('step_${index}')">Copy Gherkin</button><pre><code id="step_${index}">${trimMultipleSpaces(replacedStepDefinition)}</code></pre></div>`;
}

function validateInteger(inputElement) {
    var inputValue = inputElement.value.trim();

    // Regular expression to check if the input is a valid integer
    var integerRegExp = /^\d+$/;

    var parts = inputElement.id.split('_')
    var error_id = parts.slice(2).join('_')

    if (!integerRegExp.test(inputValue) && inputValue !== '') {
        document.getElementById(`error_message_${error_id}`).innerHTML = "<= WARNING: INTEGERS ONLY"
    } else {
        document.getElementById(`error_message_${error_id}`).innerHTML = ""
    }
}

function copyToClipboard(element_id) {
    var codeBlock = document.getElementById(element_id);
    var range = document.createRange();
    range.selectNode(codeBlock);
    window.getSelection().removeAllRanges();
    window.getSelection().addRange(range);

    try {
        // Copy the selected text to the clipboard
        document.execCommand('copy');
        alert('Gherkin step copied to clipboard!');
    } catch (error) {
        console.error('Unable to copy to clipboard', error);
    }

    window.getSelection().removeAllRanges();
}

function trimMultipleSpaces(inputString) {
    // Replace multiple spaces with a single space
    return inputString.replace(/ +/g, ' ');
}