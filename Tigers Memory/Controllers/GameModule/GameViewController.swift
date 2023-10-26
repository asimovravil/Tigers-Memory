//
//  GameViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    let images = [
        AppImage.chairCell.uiImage,
        AppImage.coinCell.uiImage,
        AppImage.boxCell.uiImage,
        AppImage.frogCell.uiImage,
        AppImage.inyanCell.uiImage,
        AppImage.cloudCell.uiImage,
        AppImage.petrCell.uiImage,
        AppImage.flagCell.uiImage,
        AppImage.megaballsCell.uiImage,
        AppImage.orangeCell.uiImage,
        AppImage.fishCell.uiImage,
        AppImage.crazyCell.uiImage,
        AppImage.houseCell.uiImage,
        AppImage.catCell.uiImage,
        AppImage.ballsCell.uiImage
    ]
    
    var shuffledImages: [UIImage?] = []
    
    // MARK: - UI
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundGame.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        shuffledImages = images.shuffled()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-150)
        }
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shuffledImages.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameCollectionViewCell.reuseID,
            for: indexPath
        ) as? GameCollectionViewCell else {
            fatalError("Could not cast to GameCollectionViewCell")
        }

        let imageIndex = indexPath.item % shuffledImages.count
        cell.cellImage.image = shuffledImages[imageIndex]

        cell.backgroundColor = .clear
        return cell
    }

}
