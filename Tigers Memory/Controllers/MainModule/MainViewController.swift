//
//  MainViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundMenu.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.playButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shopButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.shopButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.rulesButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var progressButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.progressButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(progressButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.privacyPolicy.uiImage, for: .normal)
        button.addTarget(self, action: #selector(privacyPolicyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, playButton, rulesButton, shopButton, progressButton, privacyPolicyButton].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.bottom.equalTo(rulesButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        rulesButton.snp.makeConstraints { make in
            make.bottom.equalTo(shopButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        shopButton.snp.makeConstraints { make in
            make.bottom.equalTo(progressButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        progressButton.snp.makeConstraints { make in
            make.bottom.equalTo(privacyPolicyButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        privacyPolicyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-65)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Actions
    
    @objc private func playButtonTapped() {
        let controller = LevelViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func shopButtonTapped() {
        let controller = ShopViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func rulesButtonTapped() {
        let controller = RulesViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func progressButtonTapped() {
        let controller = ProgressViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func privacyPolicyButtonTapped() {

    }
}


