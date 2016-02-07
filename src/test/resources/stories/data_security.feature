@data_security
Feature: Confidentiality of sensitive user data
  In order to protect the confidentiality of my sensitive data
  As a user
  I want to verify that the application does not allow the browser to cache my sensitive data

  @browser_only @cwe-525 @cache_control_headers
  Scenario Outline: Prevent browser caching of sensitive data
    Given a new browser instance
    And the client/browser is configured to use an intercepting proxy
    And the login page
    And the username <username>
    And the password <password>
    When the user logs in
    And the proxy logs are cleared
    And they access the restricted resource: <method>
    And the response that contains the string: <sensitiveData> is recorded
    Then the HTTP Cache-control header has the value: no-cache, no-store, must-revalidate
    And the HTTP Pragma header has the value: no-cache
    Examples:
      | method              | username   | password   | sensitiveData               |
      | viewProfileForBob   | bob        | password   | Robert                      |

