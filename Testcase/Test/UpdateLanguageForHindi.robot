*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    Dialogs
Resource   ../../Resources/Base.robot
Resource   ../../Resources/PathURL.robot
Resource   ../../Resources/SystemVariables.robot

*** Test Cases ***
[Tags]   smoke
Update Language
    Send API Request To Update Languages    ${HINDI_LANGUAGE_ID}
