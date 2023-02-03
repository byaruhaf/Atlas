//
//  SettingsViewController.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import UIKit
import SwiftUI

class SettingsViewController: UIHostingController<SettingsView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SettingsView())
    }
}
