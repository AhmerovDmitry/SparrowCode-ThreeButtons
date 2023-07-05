//
//  ViewController.swift
//  2 - three buttons
//
//  Created by Ахмеров Дмитрий Николаевич on 05.07.2023.
//

import UIKit

final class ViewController: UIViewController {

	private lazy var buttonsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .center
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupUIHierarchy()
		setupUIConstraints()
	}
}

// MARK: - Private

private extension ViewController {

	func setupUIHierarchy() {
		buttonsStackView.addArrangedSubview(buildButton(with: "First Button"))
		buttonsStackView.addArrangedSubview(buildButton(with: "Second Medium Button"))
		buttonsStackView.addArrangedSubview(buildButton(with: "Third Button", action: #selector(userDidTapButton)))
		view.addSubview(buttonsStackView)
	}

	func setupUIConstraints() {
		NSLayoutConstraint.activate([
			buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}

	func buildButton(with title: String, action: Selector = #selector(userDidTapButtonMock)) -> UIButton {
		var configuration = UIButton.Configuration.filled()
		configuration.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
		configuration.imagePadding = 8
		configuration.background.backgroundColor = .systemBlue

		let button = CustomButton()
		button.configuration = configuration
		button.setTitle(title, for: .normal)
		button.setImage(UIImage(systemName: "arrow.forward.circle"), for: .normal)
		button.semanticContentAttribute = .forceRightToLeft
		button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
		button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
		button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
		button.addTarget(self, action: action, for: .touchUpInside)

		return button
	}

	@objc func userDidTapButtonMock() {}
	@objc func userDidTapButton(_ sender: UIButton) {
		let modalController = UIViewController()
		modalController.view.backgroundColor = .systemGreen

		present(modalController, animated: true)
	}
}

// MARK: - Button animations

@objc private extension ViewController {

	func buttonTouchDown(_ sender: UIButton) {
		UIView.animate(
			withDuration: 0.1,
			delay: 0,
			options: [.allowUserInteraction, .beginFromCurrentState],
			animations: {
				sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
			}
		)
	}

	func buttonTouchUp(_ sender: UIButton) {
		UIView.animate(
			withDuration: 0.1,
			delay: 0,
			options: [.allowUserInteraction, .beginFromCurrentState],
			animations: {
				sender.transform = CGAffineTransform.identity
			}
		)
	}
}
