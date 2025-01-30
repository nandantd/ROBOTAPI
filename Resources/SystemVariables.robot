*** Settings ***
Resource   ../Resources/Base.robot
Resource   ../Resources/PathURL.robot

*** Variables ***
${BASE_URL}          https://kukufm.com
${PHONENUMBER}        +917777711323
&{HEADERS}            Content-Type=application/json    User-Agent=chrome
${PACKAGE_NAME}     com.vlv.aravali
${HINDI_LANGUAGE_ID}       1
${ENGLISH_LANGUAGE_ID}     2
${TAMIL_LANGUAGE_ID}       8
${TELUGU_LANGUAGE_ID}      3
${KANNADA_LANGUAGE_ID}     13
${MALAYALAM_LANGUAGE_ID}   9
${MARATHI_LANGUAGE_ID}     4
${BENGALI_LANGUAGE_ID}     5
${GUJRATI_LANGUAGE_ID}     6
${KOREAN_LANGUAGE_ID}      1406
