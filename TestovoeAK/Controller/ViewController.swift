//
//  ViewController.swift
//  TestovoeAK
//
//  Created by MacBook Air on 13.03.2024.
//

import UIKit
import Combine

final class ViewController: UICollectionViewController {
  
    private var cancellables = Set<AnyCancellable>()
    private var randomNumber = Int()
    private var sections: [Int] = Array(repeating: 0, count: Int.random(in: 100...200))
    private var items: [Int] = Array(repeating: Int.random(in: 10...50), count: Int.random(in: 10...50))

  init() {
    super.init(collectionViewLayout: ViewController.createLayout())
  }
  
  static func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (section, _) ->
      NSCollectionLayoutSection? in
      let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(100)))
      item.contentInsets.trailing = 16
      item.contentInsets.bottom = 16

      let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets.leading = 16

      return section
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .secondarySystemBackground
    collectionView.backgroundColor = .white
    collectionView.register(SquareCell.self, forCellWithReuseIdentifier: SquareCell.reuseIdentifier)
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCell.reuseIdentifier, for: indexPath) as? SquareCell else { return UICollectionViewCell()
    }
 
    cell.configureCellText(with: Int.random(in: 0...50))
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let squareCell = cell as? SquareCell else { return }
    if indexPath.item == Int.random(in: 0...3) {
      squareCell.updateLabelText()
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareCell.reuseIdentifier, for: indexPath) as? SquareCell {
      cell.timer.upstream.connect().cancel()
    }
  }
}

#Preview {
  ViewController()
}
