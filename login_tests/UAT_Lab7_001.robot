*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver.exe   
${Form}    http://${SERVER}/Form.html
${Complete}    http://${SERVER}/Complete.html

*** Test Cases ***
Test Form Submission with Valid Data
    [Documentation]    ทดสอบการส่งฟอร์มด้วยข้อมูลที่ถูกต้อง
    Open Browser       ${Form}    chrome
    Input Text         id=firstname      Somsong
    Input Text         id=lastname       Sandee
    Input Text         id=destination    Europe
    Input Text         id=contactperson  Sodsai Sandee
    Input Text         id=relationship   Mother
    Input Text         id=email          somsong@kkumail.com
    Input Text         id=phone          081-111-1234
    Sleep              4s
    Click Button       id=submitButton
    Close Browser
    Open Browser       ${Complete}    chrome
    Sleep              5s
    Close Browser
    
