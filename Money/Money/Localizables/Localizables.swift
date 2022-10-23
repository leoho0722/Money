//
//  Localizables.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

enum LocalizationKeys: String {
    
    // MARK: - Alert
    
    case Close = "Close"
    
    // MARK: - Alert Message
    
    // SettingsForegroundStyleView
    case App_appearance_will_change_the_next_time_you_open_it = "App appearance will change the next time you open it."
    case App_theme_color_will_change_the_next_time_you_open_it = "App theme color will change the next time you open it"
    
    // AddNewRecordView
    case AmountHasNotBeenEntered = "Amount has not been entered."
    case SaveSucceed = "Save Succeed."
    
    // MARK: - TabView
    
    case MoneyBook = "Money Book"
    
    case NewRecord = "New Record"
    
    case Settings = "Settings"
    
    // MARK: - AddNewRecordView
    
    case RecordType = "Record Type"
    case Today = "Today"
    case Price = "Price"
    case EnterAmount = "Enter amount"
    case Expenditure = "Expenditure"
    case Income = "Income"
    case Category = "Category"
    case Account = "Account"
    case NotesSomething = "Notes Something..."
    case Meals = "Meals"
    case Traffic = "Traffic"
    case Entertainment = "Entertainment"
    case TelecomCharges = "Telecom Charges"
    case WaterBill = "Water Bill"
    case GasFee = "Gas Fee"
    case Cash = "Cash"
    case Bank = "Bank"
    case CreditCard = "Credit Card"
    
    // MARK: - SettingsView
    
    case Dark = "Dark"

    case Light = "Light"
    
    case Appearance = "Appearance"
    
    case AppAppearance = "App Appearance"
    
    case AppTheme = "App Theme"
    
    case AppThemeColor = "App Theme Color"
}

func transalte(key: LocalizationKeys) -> String {
    return NSLocalizedString(key.rawValue, comment: "")
}
