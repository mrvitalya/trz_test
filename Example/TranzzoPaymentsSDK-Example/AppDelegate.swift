//
//  AppDelegate.swift
//  TranzzoPaymentsSDK-Example
//
//  Created by user on 20.04.2022.
//

import UIKit
import TranzzoPaymentSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var localizationConfig = LocalizationConfig()
        localizationConfig.main_title = "main_title"
        localizationConfig.enter_amount_title = "enter_amount_title"
        localizationConfig.enter_amount_placeholder = "enter_amount_placeholder"
        localizationConfig.pay_via_card_title = "pay_via_card_title"
        localizationConfig.pay_button_title = "pay_button_title"
        localizationConfig.wrong_card_data_title = "wrong_card_data_title"
        localizationConfig.card_number_placeholder = "card_number_placeholder"
        localizationConfig.card_exp_month_placeholder = "card_exp_month_placeholder"
        localizationConfig.card_exp_year_plaecholder = "card_exp_year_plaecholder"
        localizationConfig.card_cvv_placeholder = "card_cvv_placeholder"
        localizationConfig.cancel_payment_title = "cancel_payment_title"
        localizationConfig.cancel_payment_description = "cancel_payment_description"
        localizationConfig.cancel_payment_confirm = "cancel_payment_confirm"
        localizationConfig.cancel_payment_cancel = "cancel_payment_cancel"
        
        
        TranzzoPaymentSDK.setConfig(paymentConfig: PaymentsConfig(environment: .sandbox, currency: "UAH", applePay: ApplePayConfig(merchantId: "yout_merchat_id", countryCode: "UA")), uiConfig: PaymentContollerConfig(colorConfig: ColorConfig(), localizationConfig: localizationConfig))
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

