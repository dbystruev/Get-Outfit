//
//  api/plans/Code.js
//
//  Created by Denis Bystruev on 19/04/2020.
//

// Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
function doGet(request) {
    let answersSheet;

    // Function finds answer with given id
    function getAnswers(id) {
        // Define the range where we'll get the answers from
        const firstRow = answersSheet.getFrozenRows() + 1;
        const lastRow = answersSheet.getLastRow();
        const lastColumn = answersSheet.getLastColumn();
        const range = answersSheet.getRange(firstRow, 1, lastRow - firstRow + 1, lastColumn);

        // Get the values for all answers
        const rangeValues = range.getValues();

        // Get the answers for the row with given question id
        const answerRow = rangeValues.find(row => row[0] == id);

        // If id is not found return an empty array
        if (!answerRow) return [];

        // Return non-empty cells
        return answerRow.slice(1).filter(cell => nonEmpty(cell));
    }

    function nonEmpty(value) {
        return value || value === 0 || value === false ? value : undefined;
    }

    // Failing by default
    let message = 'default message';
    let result = { 'status': 'FAILED', 'message': message };

    try {
        // Get the query parameters
        const quizSheetId = request.parameter.quizSheetId;

        // Check the parameters
        if (!quizSheetId) throw 'quizSheetId should not be empty';

        // Get the query parameters
        const token = request.parameter.token;

        // Check the parameters
        if (!token) throw 'token should not be empty';

        // Open Google Sheet using ID
        const mainSheet = SpreadsheetApp.openById(quizSheetId);

        // Check maybe not needed, but just for case
        if (!mainSheet) throw `Can't open the quiz sheet with id ${quizSheetId}`;

        // Get the Answers sheet
        answersSheet = mainSheet.getSheetByName('Answers');
        const questionsSheet = mainSheet.getSheetByName('Questions');

        if (!answersSheet || !questionsSheet)
            throw 'The spreadsheet should have both Answers and Questions sheets';

        // Find the token hash from spreadsheet
        const savedTokenHash = questionsSheet.getRange('B1').getCell(1, 1).getValue();

        // Find the hash of the incoming token (byte to hex https://stackoverflow.com/a/51863912)
        const tokenHash = Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, token)
            .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
            .join('');

        // Check if the tokens match
        if (savedTokenHash != tokenHash) throw `Token is not correct`;

        // Get the version number
        const version = questionsSheet.getRange('B2').getCell(1, 1).getValue();

        // Define the range where we'll get the questions from
        const firstRow = questionsSheet.getFrozenRows() + 1;
        const lastRow = questionsSheet.getLastRow();
        const range = questionsSheet.getRange('A' + firstRow + ':K' + lastRow);

        // Get the values for all questions
        const rangeValues = range.getValues();

        // Map each row of rangeValues to an obect
        // FIXME: match lib/models/questions.dart
        let questions = [[]];
        rangeValues.forEach(row => {
            const length = questions.length;
            const page = row[1];
            if (page < 1) return;
            if (length < page) questions.push.apply(questions, Array.fill(page - length, []));
            const id = row[0];
            if (id < 1) return;
            let question = {};
            question['type'] = nonEmpty(row[2]);
            question['id'] = id;
            question['gender'] = nonEmpty(row[3]);
            question['isVisual'] = nonEmpty(row[4]);
            question['title'] = nonEmpty(row[5]);
            question['subtitle'] = nonEmpty(row[6]);
            question['answers'] = getAnswers(id);
            question['defaultAnswer'] = nonEmpty(row[7]);
            question['hint'] = nonEmpty(row[8]);
            question['minValue'] = nonEmpty(row[9]);
            question['maxValue'] = nonEmpty(row[10]);
            questions[page - 1].push(question);
        });

        // should match lib/models/questions.dart
        result = {
            'message': message,
            'questions': questions,
            'status': 'SUCCESS',
            'version': version,
        };
    } catch (error) {
        result = { 'status': 'ERROR', 'message': 'Quiz: ' + error };
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(result))
        .setMimeType(ContentService.MimeType.JSON);
}
