*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    Dialogs
Resource   ../Resources/SystemVariables.robot
Resource   ../Resources/PathURL.robot


*** Variables ***

${Authorization}      ${EMPTY}  # Initialize ACCESS_TOKEN variable globally
&{SEND_PAYLOAD}       phone_number=${PHONENUMBER}

*** Keywords ***
Send And Verify OTP
    [Documentation]    Sends OTP and verifies it using the API, then stores the access token globally
    Create Session    kukufm    ${BASE_URL}    verify=True

    # Send OTP
    ${response}    POST On Session
    ...    kukufm
    ...    url=${SENDOTPENDPOINT}
    ...    json=${SEND_PAYLOAD}
    ...    headers=${HEADERS}

    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Headers: ${response.headers}
    Log To Console    Response Body: ${response.content}

    Should Be Equal As Integers    ${response.status_code}    200

    ${Json_response}    Convert String To Json    ${response.content}
    ${VerificationId}    Get From Dictionary    ${Json_response}    verification_id
    Log To Console    Verification ID: ${VerificationId}

    # Call Verify OTP to obtain and set access token
    Verify OTP    ${VerificationId}

Verify OTP
    [Arguments]    ${VerificationId}
    Create Session    kukufm    ${BASE_URL}    verify=True

    # Define the verify payload
    &{verify_payload}    Create Dictionary
    ...    phone_number=${PHONENUMBER}
    ...    otp=9999
    ...    verification_id=${VerificationId}

    ${verify_response}    POST On Session
    ...    kukufm
    ...    url=${VERIFYOTPENDPOINT}
    ...    json=${verify_payload}
    ...    headers=${HEADERS}

    Log To Console    Response Status: ${verify_response.status_code}
    Log To Console    Response Body: ${verify_response.content}

    Should Be Equal As Integers    ${verify_response.status_code}    200

    # Get the token from the response
    ${verify_json_response}    Convert String To Json    ${verify_response.content}
    ${access_token}    Get From Dictionary    ${verify_json_response}    token

    # Log and set the global variable
    Log To Console    "Access token extracted: ${access_token}"
    Set Global Variable    ${ACCESS_TOKEN}    ${access_token}  # Set the global variable

Get AccessToken
    [Documentation]    Logs the Access Token from the previous file
    Send And Verify OTP
    Set Global Variable    ${Authorization}    jwt ${ACCESS_TOKEN}
    Log To Console    Authorization Token: ${Authorization}


Send API Request To Update Languages
    [Arguments]  ${HINDI_LANGUAGE_ID}
    [Documentation]    Sends a POST request to the API with necessary headers and data
    Create Session    kukufm    ${BASE_URL}
    ${headers}=    Create Dictionary    Authorization=${Authorization}  package-name=${PACKAGE_NAME}    Content-Type=application/x-www-form-urlencoded
    ${data}=    Create Dictionary    language_ids=${HINDI_LANGUAGE_ID}

    ${response}=    POST On Session    kukufm    url=${CheckForLanguage}   headers=${headers}    data=${data}

    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.content}

    Should Be Equal As Integers    ${response.status_code}    200