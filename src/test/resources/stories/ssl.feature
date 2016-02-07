@ssl
Feature:
  In order to protect my data transmitted over the network
  As a user
  I want to verify that good SSL practices have been implemented and known weaknesses have been avoided

  @ssl_crime
  Scenario: Disable SSL deflate compression in order to mitigate the risk of the CRIME attack
    Given the SSLyze command is run against the secure base Url
    Then the output must contain the text "Compression disabled"

  @ssl_client_renegotiations
  Scenario: Disable client renegotiations
    Given the SSLyze command is run against the secure base Url
    Then the output must contain a line that matches the regular expression ".*Client-initiated Renegotiations:\s+OK - Rejected.*"

  @ssl_strong_cipher
  Scenario: The minimum cipher strength should be at least 128 bit
    Given the SSLyze command is run against the secure base Url
    Then the minimum key size must be 128 bits

  @ssl_disabled_protocols
  Scenario: Disable weak SSL protocols due to numerous cryptographic weaknesses
    Given the SSLyze command is run against the secure base Url
    Then the following protocols must not be supported
      | protocol |
      | SSLV1    |
      | SSLV2    |
      | SSLV3    |

  @ssl_support_strong_protocols
  Scenario: Support TLSv1.2
    Given the SSLyze command is run against the secure base Url
    Then the following protocols must be supported
      | protocol |
      | TLSV1_2  |

  @ssl_perfect_forward_secrecy
  Scenario: Enable Perfect forward secrecy
    Given the SSLyze command is run against the secure base Url
    Then any of the following ciphers must be supported
      | cipher                         |
      | ECDHE-RSA-AES128-SHA           |
      | ECDHE-RSA-AES256-SHA           |
      | DHE-DSS-CAMELLIA128-SHA        |
      | DHE-DSS-CAMELLIA256-SHA        |
      | DHE-RSA-CAMELLIA128-SHA        |
      | DHE-RSA-CAMELLIA256-SHA        |
      | ECDHE-ECDSA-CAMELLIA128-SHA256 |
      | ECDHE-ECDSA-CAMELLIA256-SHA384 |
      | ECDH-ECDSA-CAMELLIA128-SHA256  |
      | ECDH-ECDSA-CAMELLIA256-SHA384  |
      | ECDHE-RSA-CAMELLIA128-SHA256   |
      | ECDHE-RSA-CAMELLIA256-SHA384   |
      | ECDH-RSA-CAMELLIA128-SHA256    |
      | ECDH-RSA-CAMELLIA256-SHA384    |

  @ssl_heartbleed
  Scenario: Patch OpenSSL against the Heartbleed vulnerability
    Given the SSLyze command is run against the secure base Url
    Then the output must contain the text "Not vulnerable to Heartbleed"
