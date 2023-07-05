//
//  CustomButton.swift
//  2 - three buttons
//
//  Created by Ахмеров Дмитрий Николаевич on 05.07.2023.
//

import UIKit

final class CustomButton: UIButton {

	override func tintColorDidChange() {
		super.tintColorDidChange()
		configuration?.background.backgroundColor = tintAdjustmentMode == .dimmed ? .systemGray : .systemBlue
	}
}
