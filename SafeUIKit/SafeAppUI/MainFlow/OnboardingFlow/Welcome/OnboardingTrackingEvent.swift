//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import Foundation
import Common

/// These events are still used for funnel testing. They will be removed.
enum OnboardingEvent: String, Trackable {

    case welcome                = "Onboarding_Welcome"
    case setPassword            = "Onboarding_SetPassword"
    case confirmPassword        = "Onboarding_ConfirmPassword"
    case guidelines             = "Onboarding_RecoveryIntro"
    case recoveryPhrase         = "Onboarding_ShowSeed"
    case confirmRecovery        = "Onboarding_EnterSeed"
    case configure              = "Onboarding_Configure"
    case createSafe             = "Onboarding_CreationFee"
    case safeFeePaid            = "Onboarding_FeePaid"

}

enum CreateSafeTrackingEvent: String, ScreenTrackingEvent {

    case onboarding1                    = "CreateSafe_Onboarding1"
    case onboarding2                    = "CreateSafe_Onboarding2"
    case onboarding3                    = "CreateSafe_Onboarding3"
    case onboarding4                    = "CreateSafe_Onboarding4"
    case threeSteps                     = "CreateSafe_ThreeSteps"
    case setup2FA                       = "CreateSafe_Setup2FA"
    case seedIntro                      = "CreateSafe_SeedIntro"
    case connectAuthenticatorSuccess    = "CreateSafe_ConnectAuthenticatorSuccess"

}

enum TwoFATrackingEvent: String, ScreenTrackingEvent {

    case setup2FADevicesList            = "Pair2FA_Setup2FADevicesList"
    case openStatusKeycardInfo          = "Pair2FA_KeycardInfo"
    case openAuthenticatorInfo          = "Pair2FA_AuthenticatorInfo"
    case connectAuthenticator           = "Pair2FA_ConnectAuthenticator"
    case connectAuthenticatorScan       = "Pair2FA_ConnectAuthenticatorScan"
    case pairKeycard                    = "Pair2FA_PairKeycard"
    case activateKeycard                = "Pair2FA_ActivateKeycard"
    case pairSuccess                    = "Pair2FA_KeycardSuccess"

}

/// Tracking events occuring during onboarding flows.
enum OnboardingTrackingEvent: String, ScreenTrackingEvent {

    case welcome                    = "Onboarding_Welcome"
    case terms                      = "Onboarding_Terms"
    case setPassword                = "Onboarding_SetPassword"
    case confirmPassword            = "Onboarding_ConfirmPassword"
    case createOrRestore            = "Onboarding_CreateOrRestore"
    case newSafeGetStarted          = "Onboarding_NewSafeGetStarted"
    case recoveryIntro              = "Onboarding_RecoveryIntro"
    case showSeed                   = "Onboarding_ShowSeed"
    case enterSeed                  = "Onboarding_EnterSeed"
    case twoFAScanSuccess           = "Onboarding_2FAScanSuccess"
    case twoFAScanError             = "Onboarding_2FAScanError"
    case createSafeFeeIntro         = "Onboarding_CreationFeeIntro"
    case createSafePaymentMethod    = "Onboarding_PaymentMethod"
    case creationFee                = "Onboarding_CreationFee"
    case feePaid                    = "Onboarding_FeePaid"

}
