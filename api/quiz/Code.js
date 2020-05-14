//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
function doGet(request) {
    let answerSheet;
    let questionSheet;

    // Failing by default
    let message = 'default message';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (!token) throw 'token should not be empty';

        // Open Google Sheet bound with this script
        const mainSheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!mainSheet) throw 'Can\'t open the quiz sheet';

        // Get the Answers & Questions sheets
        answerSheet = mainSheet.getSheetByName('Answers');
        questionSheet = mainSheet.getSheetByName('Questions');

        if (!answerSheet || !questionSheet)
            throw 'The spreadsheet should have both Answers and Questions sheets';

        // Find the token hash from spreadsheet
        const savedTokenHash = getTokenRange(questionSheet).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

        // Get the version number
        const version = getVersionRange(questionSheet).getValue();

        // Get the values for all questions and all answers
        const answerValues = getAllValues(answerSheet);
        const questionValues = getAllValues(questionSheet);

        // Map each row of rangeValues to an obect
        let questions = [[]];
        questionValues.forEach(row => {
            const id = row[0];
            if (id < 1) return;
            const page = row[1];
            if (page < 1) return;
            const question = {
                'id': id,
                'isEnabled': nonEmpty(row[2]),
                'type': nonEmpty(row[3]),
                'gender': nonEmpty(row[4]),
                'isVisual': nonEmpty(row[5]),
                'title': nonEmpty(row[6]),
                'subtitle': nonEmpty(row[7]),
                'answers': getAnswersForQuestionId(answerValues, id),
                'defaultAnswer': getDefaultAnswer(row[8]),
                'hint': nonEmpty(row[9]),
                'minValue': nonEmpty(row[10]),
                'maxValue': nonEmpty(row[11])
            };
            while (questions.length < page) questions.push([]);
            questions[page - 1].push(question);
        });

        // Should match lib/models/questions.dart
        result = {
            'message': message,
            'questions': questions,
            'status': 'SUCCESS',
            'time': getSecondsFromEpoch(),
            'version': version,
        };
    } catch (error) {
        result = {
            'message': 'Quiz: ' + error,
            'status': 'ERROR',
            'time': getSecondsFromEpoch()
        };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}

function doPost(request) {
    // Failing by default
    let answersSheet;
    let questionsSheet;
    let message = 'default message';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (!token) throw 'token should not be empty';

        // Open Google Sheet bound with this script
        const mainSheet = SpreadsheetApp.getActiveSpreadsheet();

        // Check maybe not needed, but just for case
        if (!mainSheet) throw 'Can\'t open the quiz sheet';

        // Get the Answers & Questions sheets
        answersSheet = mainSheet.getSheetByName('Answers');
        questionsSheet = mainSheet.getSheetByName('Questions');

        if (!answersSheet || !questionsSheet)
            throw 'The spreadsheet should have both Answers and Questions sheets';

        // Find the token hash from spreadsheet
        const savedTokenHash = getTokenRange(questionsSheet).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

        // Get the questions data
        const jsonString = request.postData.getDataAsString();

        // Parse the POST body
        const body = JSON.parse(jsonString);
        const questions = body.questions;

        // Loop through all questions
        for (let page = 0; page < questions.length; page++) {

            // Loop through a given page
            for (let question of questions[page]) {

                // Construct individual question
                const questionRow = [
                    question.id,
                    page + 1,
                    question.isEnabled,
                    question.type,
                    question.gender,
                    question.isVisual,
                    question.title,
                    question.subtitle,
                    getAnswer(question.defaultAnswer),
                    question.hint,
                    question.minValue,
                    question.maxValue,
                ];

                // Append the question
                questionsSheet.appendRow(questionRow);

                // Construct the answers
                if (question.answers && 0 < question.answers.length) {
                    const answers = [question.id].concat(question.answers);
                    answersSheet.appendRow(answers);
                }
            }
        }

        // Update version in the sheet
        updateVersion(questionsSheet);

        // Set the success response
        result = {
            'status': 'SUCCESS',
            'time': getSecondsFromEpoch()
        }

    } catch (error) {
        result = {
            'message': 'Quiz Post: ' + error,
            'status': 'ERROR',
            'time': getSecondsFromEpoch()
        };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}

// Get all answer values from a range in given sheet
function getAllValues(sheet) {
    // Define the range where we'll get the answers from
    const firstColumn = sheet.getFrozenColumns() + 1;
    const firstRow = sheet.getFrozenRows() + 1;
    const lastColumn = sheet.getLastColumn();
    const lastRow = sheet.getLastRow();
    const range = sheet.getRange(
        firstRow,
        firstColumn,
        lastRow < firstRow ? 1 : lastRow - firstRow + 1,
        lastColumn < firstColumn ? 1 : lastColumn - firstColumn + 1
    );

    // Return the values for all answers
    return range.getValues();
}

function getAnswer(answer) {
    // Check if indexes present
    if (answer.indexes) return '[' + answer.indexes.join() + ']';

    // Check if text is present
    if (answer.text) return answer.text;

    // Check if value is present
    if (answer.value) return answer.value;

    return undefined;
}

// Finds answers with a given id withing given range of values
function getAnswersForQuestionId(rangeValues, id) {
    // Get the answers for the row with given question id
    const answerRow = rangeValues.find(row => row[0] == id);

    // If id is not found return an empty array
    if (!answerRow) return undefined;

    // Get non-empty cells as array of strings
    const answers = answerRow.slice(1).filter(cell => nonEmpty(cell)).map(cell => cell.toString());

    return answers;
}

// Get defaultAnswer field
function getDefaultAnswer(answer) {
    if (Number.isInteger(answer)) return { 'value': answer };
    if (Array.isArray(answer)) return { 'indexes': answer };

    const trimmedAnswer = nonEmpty(answer.trim());
    if (trimmedAnswer == '[]') return { 'indexes': [] };

    const length = trimmedAnswer.length;
    if (length < 3 ||
        trimmedAnswer[0] != '[' ||
        trimmedAnswer[length - 1] != ']'
    )
        return { 'text': answer };

    const internalString = trimmedAnswer.slice(1, length - 1).trim();
    const internalNumber = Number(internalString);
    if (Number.isInteger(internalNumber))
        return { 'indexes': [internalNumber] };
        
    return { 'text': answer };
}

// Get current time in seconds from Jan 1, 1970
function getSecondsFromEpoch() {
    return Math.floor(new Date().getTime() / 1000);
}

function getTokenRange(sheet) {
    return sheet.getRange('G1');
}

function getVersionRange(sheet) {
    return sheet.getRange('G2');
}

function nonEmpty(value) {
    return value || value === 0 || value === false ? value : undefined;
}

// Derived from https://webapps.stackexchange.com/a/117630
function onEdit(event) {
    // Return if event is null/empty
    if (!event) return;

    // Get the sheet for date cell
    const sheet = event.source.getSheetByName('Questions');

    // Update version
    return updateVersion(sheet);
}

// Pads the value with 0 if value < 10
function padded(value) {
    return value < 10 ? '0' + value : value;
}

function updateVersion(sheet) {
    // Calculate the version depending on date + time
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hour = date.getHours();
    const minute = date.getMinutes();
    const second = date.getSeconds();
    const version = '' +
        year + padded(month) + padded(day) + padded(hour) + padded(minute) + padded(second);

    // Update the version cell
    getVersionRange(sheet).setValue(version);

    return true;
}