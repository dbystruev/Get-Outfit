//
//  api/orders/Code.js
//
//  Created by Denis Bystruev on 19/04/2020, updated on 03/05/2020, 14/05/2020.
//
//  This script address is:
//  https://script.google.com/macros/s/AKfycbx9Hdbu322konV5S-_G9Zy_7UQpPR4fEz4LPRL9BjTglh3EER9s/exec
//
//  Derived from:
//  https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

// GET 
function doGet(request) {
    // Make user sheet available outside of try/catch block
    let userSheet;

    // Failing by default
    let message = '';
    let response = { 'status': 'FAILED', 'message': message };

    try {
        // Disable due when needed
        // throw 'not implemented.  Contact developer at dbystruev@me.com or github.com/dbystruev';

        // Try to open the sheet bound to this script and throw if it fails
        const spreadsheet = tryToGetActiveSpreadsheet();

        // Get the users sheet
        userSheet = spreadsheet.getSheetByName('Users');

        if (isEmpty(userSheet))
            throw 'The spreadsheet should have at least Users sheet';

        // Get the tokens, check them and throw if they are absent or are not correct
        tryToCheckTokens(userSheet, request);

        // Get the phone from query parameters
        const phone = request.parameter.phone;

        // Check for the phone presense
        if (isEmpty(phone)) throw 'The phone parameter should not be empty';

        // Check if the phone has from 9 to 15 digits
        // https://www.quora.com/What-is-maximum-and-minimum-length-of-any-mobile-number-across-the-world
        const phoneDigits = getDigits(phone);
        const phoneDigitsLength = phoneDigits.length;
        if ((phoneDigitsLength < 9 || 15 < phoneDigitsLength) && phone != 'newuser')
            throw 'The phone should have between 9 and 15 digits or be a newuser';

        // Define the range where we'll get the users from
        const userRange = getDataRange(userSheet);

        // Get the users for the whole range
        const userRangeValues = userRange.getValues();

        // Get the users whose phone matches
        // 4 is the index of the phone in the user sheet (column E or 5)
        let matchingUser = userRangeValues.find(row => getDigits(row[4]) == phoneDigits);

        // Create user object for future response
        let user = {};

        // Get the response code
        const responseCode = request.parameter.responseCode;

        // Check if any matching users found
        if (isNotEmpty(matchingUser) && 5 < matchingUser.length && phone != 'newuser') {
            // Get matching user's id
            const userId = matchingUser[0];

            // Check that the user id is present
            if (isEmpty(userId)) throw 'User id for the given phone number is empty';

            // Fill user object with data
            user = {
                'id': userId,
                'avatar': nonEmptyValue(matchingUser[1]),
                'email': nonEmptyValue(matchingUser[2]),
                'name': nonEmptyValue(matchingUser[3]),
                'phone': nonEmptyValue(matchingUser[4]),
                'registrationDate': nonEmptyValue(matchingUser[5])
            }
        } else {
            // No users matched, create new user
            const userId = getNextId(userSheet);

            // Create the user registration date as now
            const registrationDate = getFormattedDate(
                new Date(),
                dateSplitter = '-',
                dateTimeSplitter = ' ',
                timeSplitter = ':'
            );

            // Compose a row for appending to the table
            const row = [userId, null, null, null, '\'' + phone, registrationDate, responseCode];

            // Add row to the table
            userSheet.appendRow(row);

            // Update the version of the user sheet
            updateVersion(userSheet);

            // Fill the new user object with data we know so far
            user = {
                'id': userId,
                'phone': phone,
                'registrationDate': registrationDate
            }
        }

        // Check that the response code was provided
        if (isEmpty(responseCode)) {
            // It wasn't — we need to generate one a random one from 0 to 9999
            let generatedCode = Math.floor(10000 * Math.random()).toString();

            // Add padding 0s for 0000...0009, 0010...0099, and 0100...0999
            while (generatedCode.length < 4) generatedCode = '0' + generatedCode;

            // Phones which start with 7 (+7 included) are test phones
            if (true) { // temporary solution // phoneDigits[0] == '7') {
                // For test phones use app provided code
                generatedCode = request.parameter.generatedCode;
            } else {
                // For all other phones call the SMSGlobal API to send SMS
                const url = 'https://api.smsglobal.com/http-api.php' +
                    '?action=sendsms' +
                    '&user=...' +
                    '&password=...' +
                    '&from=...' +
                    '&to=' + phoneDigits +
                    '&text=Your%20code:%20' + generatedCode;
                const response = UrlFetchApp.fetch(url, { 'muteHttpExceptions': true });

                // Save API response to the sheet
                getUserAPIResultRange(userSheet, user.id).setValue(response);
            }

            // Let the app know that it needs to provide the code
            if (isEmpty(generatedCode))
                throw 'You need to provide generated code';

            // Save generated code for future check
            getUserResponseCodeRange(userSheet, user.id).setValue(generatedCode);

            // Add generated code to the user data as user token (will be overwritten later)
            user = getMergedObject(user, {
                'token': generatedCode
            });

        } else {
            // Response code was sent — we need to check its validity
            const savedCode = getUserResponseCodeRange(userSheet, user.id).getValue();
            if (responseCode != savedCode)
                throw 'The response code is not correct';

            // If response code was correct we need to generate individual user token
            const userToken = getHash(new Date().getTime());

            // Save user token hash for future check
            getUserTokenRange(userSheet, user.id).setValue(getHash(userToken));

            // Add user token to user data
            user = getMergedObject(user, {
                'token': userToken
            });
        }

        // Overwrite the response with the user and success status
        response = getMergedObject(response, {
            'message': message,
            'serverData': { 'user': user },
            'status': 'SUCCESS',
            'time': getSecondsFromEpoch()
        });

    } catch (error) {
        // Overwrite the response with the error status
        response = getMergedObject(response, {
            'message': 'Feedback API: ' + error,
            'status': 'ERROR',
            'time': getSecondsFromEpoch()
        });
    }
    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(response))
        .setMimeType(ContentService.MimeType.JSON);
}

function doPost(request) {
    // Plans for filling order table (should match lib/models/plan+all.dart)
    const plans = [
        { name: 'Get Outfit', price: 1490 },
        { name: 'Get Wardrobe', price: 3490 },
    ];

    // Make sheets available outside of try/catch block
    let answerSheet;
    let orderSheet;
    let userSheet;

    // Failing by default
    let dataFound = false;
    let message = '';
    let response = { 'status': 'FAILED', 'message': message };

    try {
        // Try to open the sheet bound with this script and throw if it fails
        const spreadsheet = tryToGetActiveSpreadsheet();

        // Get the answer, order, and user sheets
        answerSheet = spreadsheet.getSheetByName('Answers');
        orderSheet = spreadsheet.getSheetByName('Orders');
        userSheet = spreadsheet.getSheetByName('Users');

        if (isEmpty(answerSheet) || isEmpty(orderSheet) || isEmpty(userSheet))
            throw 'The spreadsheet should have Answers, Orders, and Users sheets';

        // Get the tokens, check them and throw if they are absent or are not correct
        tryToCheckTokens(userSheet, request);

        // Check that post data is present
        const postData = request.postData;
        if (isEmpty(postData)) throw 'No post data is found';

        // Get the questions data
        const jsonString = postData.getDataAsString();

        // Parse the POST body
        const body = JSON.parse(jsonString);
        let serverData = body.serverData;

        // Check if we have serverData container
        if (isEmpty(serverData)) throw 'No server data is found in post data';

        // Get the user associated with the order
        let user = serverData.user;

        // Check that the user is present, their id and user token are valid
        tryToValidateUser(userSheet, user);

        // Get the user id from the load
        const userId = user.id;

        // Check if answers are present and were not submitted earlier
        const answers = serverData.answers;
        if (areValidAnswers(answers)) {
            dataFound = true;

            // Define the range where we'll get the answers from
            const answerRange = getDataRange(answerSheet);

            // Get the answers for the whole range
            const answerRangeValues = answerRange.getValues();

            // Get the answers whose user.id matches
            // 1 is the index of the user.id in the answer sheet (2nd column — B)
            let matchingAnswer = answerRangeValues.find(row => row[1] == userId);

            // Remember if there is matching answer
            const foundMatchingAnswer = isNotEmpty(matchingAnswer) && 3 < matchingAnswer.length;

            // Use answer id from matchingAnswer if found, create new answer if not
            const answerId = foundMatchingAnswer ? matchingAnswer[0] : getNextId(answerSheet);

            // Compose the row of answers data
            const answerValues = [answerId, userId, answers.date, ...answers.answers];

            // Check if answers already exist in the table
            if (foundMatchingAnswer) {
                // Answers' position in the table is their id + number of frozen rows
                const answerRow = answerSheet.getFrozenRows() + answerId;

                // Number of answer columns is defined by answers array
                const answersLength = answers.answers.length + 3;

                // Get saved answers' range from the table
                const savedAnswerRange = answerSheet.getRange(answerRow, 1, 1, answersLength);

                // Save values back to the table
                savedAnswerRange.setValues([answerValues]);
            } else {
                // Add the new row with answers
                answerSheet.appendRow(answerValues);
            }

            // Update the response with the ansers
            serverData = getMergedObject(serverData, { 'answers': answers });
            response = getMergedObject(response, { 'serverData': serverData });

            // Update the version of the feedback sheet
            updateVersion(answerSheet);
        }

        // Check if order is present and wasn't submitted earlier
        let order = serverData.order;
        if (isNotEmpty(order) && isEmpty(order.id)) {
            dataFound = true;

            // Compose the row of order data
            // Id is the number of filled rows minus the number of frozen rows + 1
            const orderId = getNextId(orderSheet);

            // Update the order with the new id
            order = getMergedObject(order, { 'id': orderId });

            // Get order creation date
            const creationDate = order.creationDate;

            // Check that order creation data is present
            if (isEmpty(creationDate))
                throw 'Order creation date ' + creationDate + ' is not valid';

            // Get plan id
            const planId = order.planId;

            // Check that plan id is valid
            if (isEmpty(planId) || !Number.isInteger(planId) || planId < 0 || plans.length <= planId)
                throw 'Plan id ' + planId + ' is not valid';

            // Get the plan
            const plan = plans[planId];

            // Compose and add the order row
            const orderRow = [
                orderId,
                user.id,
                creationDate,
                planId,
                plan.price,
                plan.name
            ];
            orderSheet.appendRow(orderRow);

            // Update the response with the order
            serverData = getMergedObject(serverData, { 'order': order });
            response = getMergedObject(response, { 'serverData': serverData });

            // Update the version (reveresed date with time) of the order sheet
            updateVersion(orderSheet);
        }

        // Check if the user is present
        if (isNotEmpty(user)
            // && !isValidOrder(order) && !isValidFeedback(userFeedback)
        ) {
            dataFound = true;

            // User's position in the table is their id + number of frozen rows
            const userRow = userSheet.getFrozenRows() + userId;

            // Get saved user data from the table
            const savedUserRange = userSheet.getRange(userRow, 1, 1, 6);
            let savedUserValues = savedUserRange.getValues();
            let savedUserRow = savedUserValues[0];

            // Sanity check if we got everything right
            if (userId != savedUserRow[0])
                throw 'Found id '
                + savedUserRow[0]
                + ' in the position of user id '
                + userId
                + ' in the user table';

            // Merge provided data with the table
            savedUserRow[1] = getMergedValue(savedUserRow[1], user.avatar);
            savedUserRow[2] = getMergedValue(savedUserRow[2], user.email);
            savedUserRow[3] = getMergedValue(savedUserRow[3], user.name);
            savedUserRow[4] = getMergedValue(savedUserRow[4], user.phone);
            savedUserRow[5] = getMergedValue(savedUserRow[5], user.registrationDate);

            // Save values back to the table
            savedUserValues = [savedUserRow];
            savedUserRange.setValues(savedUserValues);

            // Update the user with the merged data for response
            user = getMergedObject(user, {
                'id': userId,
                'avatar': savedUserRow[1],
                'email': savedUserRow[2],
                'name': savedUserRow[3],
                'phone': savedUserRow[4],
                'registrationDate': savedUserRow[5]
            });

            // Update the response with the updated user data
            serverData = getMergedObject(serverData, { 'user': user });
            response = getMergedObject(response, { 'serverData': serverData });

            // Update the version of the user sheet
            updateVersion(userSheet);
        }

        if (!dataFound) throw 'No order, user, or user feedback data is found in server data';

        // Overwrite the response with the success status
        response = getMergedObject(response, {
            'message': message,
            'status': 'SUCCESS',
            'time': getSecondsFromEpoch()
        });

    } catch (error) {
        // Overwrite the response with the error status
        response = getMergedObject(response, {
            'message': 'Feedback API: ' + error,
            'status': 'ERROR',
            'time': getSecondsFromEpoch()
        });
    }

    // Return result
    return ContentService
        .createTextOutput(JSON.stringify(response))
        .setMimeType(ContentService.MimeType.JSON);
}

// Check if the answers are valid
function areValidAnswers(answers) {
    if (isEmpty(answers)) return false;
    if (isEmpty(answers.answers) || !Array.isArray(answers.answers))
        throw 'Answers array is not present';
    const answersLength = answers.answers.length;
    if (1000 < answersLength) throw 'Too many (' + answersLength + ') answers';
    if (isEmpty(answers.date)) throw 'Answers\' date is empty';
    return true;
}

// Define the range with non-empty data
function getDataRange(sheet) {
    const firstRow = sheet.getFrozenRows() + 1;
    const lastRow = sheet.getLastRow();
    const numberOfRows = lastRow < firstRow ? 1 : lastRow - firstRow + 1;
    const firstColumn = 1; // sheet.getFrozenColumns() + 1;
    const lastColumn = sheet.getLastColumn();
    const numberOfColumns = lastColumn < firstColumn ? 1 : lastColumn - firstColumn + 1;
    return sheet.getRange(firstRow, firstColumn, numberOfRows, numberOfColumns);
}

// Removes all non-digits and returns a string of pure digits
function getDigits(rawDigits) {
    const regexp = /[^\d]/g;
    return rawDigits.toString().replace(regexp, '');
}

// Format the date to 20200504191500 or 2000-05-04 19:15:00
function getFormattedDate(date, dateSplitter = '', dateTimeSplitter = '', timeSplitter = '') {
    // Calculate the version depending on date + time
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hour = date.getHours();
    const minute = date.getMinutes();
    const second = date.getSeconds();
    return '' + year + dateSplitter +
        padded(month) + dateSplitter +
        padded(day) + dateTimeSplitter +
        padded(hour) + timeSplitter +
        padded(minute) + timeSplitter +
        padded(second);
}

// Find the hash of the value (byte to hex https://stackoverflow.com/a/51863912)
function getHash(value) {
    return Utilities.computeDigest(Utilities.DigestAlgorithm.SHA_512, value)
        .map(function (chr) { return (256 + chr).toString(16).slice(-2) })
        .join('');
}

// Merge two objects and return the result
function getMergedObject(firstObject, secondObject) {
    return Object.assign({}, firstObject, secondObject);
}

// Replace existing value with a new value if the new value is not empty
function getMergedValue(existingValue, newValue) {
    return newValue == undefined ? existingValue : newValue;
}

// Get the first free id from the sheet (last row minus number of frozen rows)
function getNextId(sheet) {
    // We'll need the number of frozen/filled rows
    const filledRows = sheet.getLastRow();
    const frozenRows = sheet.getFrozenRows();

    // Get the first free id for the table
    return filledRows < frozenRows ? 1 : filledRows - frozenRows + 1;
}

// Calculate the response token based on the incoming token hash
function getResponseToken(tokenHash) {
    // Split the token hash to array for easier replacement
    const hash = tokenHash.split('');

    // Calculate the hash length
    let len = hash.length;

    // Calculate the response token
    hash[0x11111111 % len] = hash[0x22222222 % len];
    hash[0x33333333 % len] = hash[0x44444444 % len];
    hash[0x55555555 % len] = hash[0x66666666 % len];
    hash[0x77777777 % len] = hash[0x88888888 % len];

    // Assemble the hash array back to String
    const hashString = hash.join('');

    // Return the hash of calculated token
    return getHash(hashString);
}

// Get current time in seconds from Jan 1, 1970
function getSecondsFromEpoch() {
    return Math.floor(new Date().getTime() / 1000);
}

function getTokenRange(sheet) {
    return sheet.getRange('C2');
}

// Get the range of response to API call
function getUserAPIResultRange(sheet, userId) {
    const userRow = userId + sheet.getFrozenRows();
    return sheet.getRange(userRow, 9, 1, 1);
}

// Get the range of response code for the phone number
function getUserResponseCodeRange(sheet, userId) {
    const userRow = userId + sheet.getFrozenRows();
    return sheet.getRange(userRow, 7, 1, 1);
}

// Get the range of user's individual token
function getUserTokenRange(sheet, userId) {
    const userRow = userId + sheet.getFrozenRows();
    return sheet.getRange(userRow, 8, 1, 1);
}

function getVersionRange(sheet) {
    return sheet.getRange('C1');
}

function isEmpty(value) {
    return !isNotEmpty(value)
}

function isNotEmpty(value) {
    return value || value === 0 || value === false ? true : undefined;
}

function nonEmptyValue(value) {
    return value || value === 0 || value === false ? value : undefined;
}

// Update sheet version if it is edited
// Derived from https://webapps.stackexchange.com/a/117630
function onEdit(event) {
    // Return if event is null/empty
    if (!event) return;

    // Get the sheet for date cell
    const sheet = event.range.getSheet();

    // Update version
    return updateVersion(sheet);
}

// Pads the value with 0 if value < 10
function padded(value) {
    return value < 10 ? '0' + value : value;
}

// Calculate the response token and compare it with the provided one, throw if it is not correct
function tryToCheckResponseToken(tokenHash, responseToken) {
    // Calculate response token based on the incoming token
    const calculatedToken = getResponseToken(tokenHash);

    // Check if the response tokens match
    if (calculatedToken !== responseToken) throw 'Response token is not correct';
}

// Get the token hash and compare it with the saved one, throw if it is not correct
function tryToCheckToken(sheet, tokenHash) {
    // Find the token hash from spreadsheet
    const savedTokenHash = getTokenRange(sheet).getValue();

    // Check if the tokens match
    if (tokenHash !== savedTokenHash) throw 'Token is not correct';
}

// Get the tokens, check them and throw if they are absent or are not correct
function tryToCheckTokens(sheet, request) {
    // Check that the provided sheet exists
    if (isEmpty(sheet))
        throw 'The spreadsheet should have at least one sheet';

    // Get the token from query parameters and throw if it is empty
    const token = tryToGetToken(request);

    // Find the hash of the incoming token
    const tokenHash = getHash(token);

    // Get the token hash and compare it with the saved one, throw if it is not correct
    tryToCheckToken(sheet, tokenHash);

    // Gets the response token from query parameters and throws if it is empty
    const responseToken = tryToGetResponseToken(request);

    // Calculate the response token and compare it with the provided one, throw if it is not correct
    tryToCheckResponseToken(tokenHash, responseToken);
}

// Tries to open the sheet bound with this script, throws if it is empty
function tryToGetActiveSpreadsheet() {
    // Open Google Sheet bound with this script
    const spreadsheet = SpreadsheetApp.getActiveSpreadsheet();

    // Check maybe not needed, but just for case
    if (isEmpty(spreadsheet)) throw 'Can\'t open the associated spreadsheet';

    return spreadsheet;
}

// Gets the response token from query parameters and throws if it is empty
function tryToGetResponseToken(request) {
    // Get the response token from query parameters
    const responseToken = request.parameter.responseToken;

    // Check for the response token presense
    if (isEmpty(responseToken)) throw 'The response token parameter should not be empty';

    return responseToken;
}

// Gets the token from query parameters and throws if it is empty
function tryToGetToken(request) {
    // Get the token from query parameters
    const token = request.parameter.token;

    // Check for the token presense
    if (isEmpty(token)) throw 'The token parameter should not be empty';

    return token;
}

// Check that the user is present and their id is valid
function tryToValidateUser(userSheet, user) {
    // Check that the user is present
    if (isEmpty(user)) throw 'No user in server data';

    // Check the user's id presense
    const userId = user.id;
    if (isEmpty(userId)) throw 'No user id for the user';

    // Check that the user's id is a whole number
    if (!Number.isInteger(userId)) throw 'User id ' + userId + ' is not a number';

    // Check the user's id validity
    const maxUserId = getNextId(userSheet) - 1;
    if (userId < 1 || maxUserId < userId)
        throw 'Wrong user id ' + userId + ' for the user';

    // Check that user token hash matches the saved hash
    tryToValidateUserToken(userSheet, user);
}

// Check that the user is present and their id is valid
function tryToValidateUserToken(userSheet, user) {
    // Check that the token is not empty
    if (isEmpty(user.token)) throw 'No user token for the user';

    // Check that user token hash matches the saved hash
    const userTokenHash = getHash(user.token);
    const savedUserTokenHash = getUserTokenRange(userSheet, user.id).getValue();
    if (userTokenHash != savedUserTokenHash)
        throw 'Wrong user token';
}

function updateVersion(sheet) {
    // Calculate the version depending on date + time
    const version = getFormattedDate(new Date());

    // Update the version cell
    getVersionRange(sheet).setValue(version);

    return true;
}