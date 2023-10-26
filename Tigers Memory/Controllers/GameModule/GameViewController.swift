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
    var selectedCells: [GameCollectionViewCell] = []
    
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

        
        cell.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapGesture)
        cell.backgroundColor = .clear
        return cell
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        if let tappedCell = sender.view as? GameCollectionViewCell {
            // Проверяем, не открыта ли уже эта ячейка
            if !tappedCell.isFlipped {
                // Открываем ячейку и добавляем ее в массив выбранных ячеек
                tappedCell.flip()
                selectedCells.append(tappedCell)

                // Если выбрано две ячейки, сравниваем их
                if selectedCells.count == 2 {
                    checkForMatch()
                }
            }
        }
    }
    
    func checkForMatch() {
        if selectedCells.count == 2 {
            let cell1 = selectedCells[0]
            let cell2 = selectedCells[1]

            if cell1.cellImage.image == cell2.cellImage.image {
                // Если изображения совпадают, то это пара, их можно оставить открытыми
                // Очистите массив выбранных ячеек
                selectedCells.removeAll()
            } else {
                // Если изображения не совпадают, переверните ячейки обратно через некоторое время
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    cell1.flip()
                    cell2.flip()
                    // Очистите массив выбранных ячеек
                    self.selectedCells.removeAll()
                }
            }
        }
    }
}
