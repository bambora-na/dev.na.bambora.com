---
title: 3DS Reason List
layout: tutorial

summary: >
  The list of reasons for a 3DS rejection that can be supplied to the merchant.

navigation:
  header: na.tocs.na_nav_header
  footer: na.tocs.na_nav_footer
  toc: na.tocs.payment_apis
  header_active: References

---

# List of reasons for 3DS rejections

| Reason |
| ------ |
| CardAuthenticationFailed |
| UnknownDevice |
| UnsupportedDevice |
| ExceedsAuthenticationFrequencyLimit |
| ExpiredCard |
| InvalidCardNumber |
| InvalidTransaction |
| NoCardRecord |
| SecurityFailure |
| StolenCard |
| SuspectedFraud |
| TransactionNotPermittedToCardholder |
| CardholderNotEnrolledInService |
| TransactionTimedOutAtTheACS |
| LowConfidence |
| MediumConfidence |
| HighConfidence |
| VeryHighConfidence |
| ExceedsACSMaximumChallenges |
| NonPaymentTransactionNotSupported |
| ThreeRITransactionNotSupported |
| ACSTechnicalIssue |
| DecoupledAuthenticationRequiredByACSButNotRequestedBy3DSRequestor |
| ThreeDSRequestorDecoupledMaxExpiryTimeExceeded |
| DecoupledAuthenticationWasProvidedInsufficientTimeToAuthenticateCardholder |
| AuthenticationAttemptedButNotPerformedByTheCardholder |
| DelegationForcedForCb |
| AcsUnavailableForCb |
| AcsTimeoutForCb |
| ErrorWithErrorCode4xxReceivedfromAcsForCb |
| UnableToReadAcsMessageForCb |
| ScoringForCb |
| VMIDNotParticipatingInVDAorVTLForVisa |
| ACSorIssuerNotParticipatingInVDAorVTLForVisa |
| CAVVIncludedInResponseForVisa |
| ChallengeMandateRequestedButCouldNotBePerformed |
| TransStatusReason80ForMC |
| DSDroppedReasonCodeReceivedFromACSForMC |
| ExcludedFromAttemptsForVisa |
| ChallengeCancelPopulatedThereforeDidNotRouteToSmartAuthenticationStandInForMC |
| PanOrTokenNotEligibleForSafeKey |
| MessageVersionNumberNotSupportedByAcsForPanOrTokenForSafeKey |
