*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    Dialogs
Resource   ../../Resources/Base.robot
Resource   ../../Resources/PathURL.robot
Resource   ../../Resources/SystemVariables.robot


*** Test Cases ***
Send API Request To Get Languages
    Send API Request To Update Languages    ${TELUGU_LANGUAGE_ID}


