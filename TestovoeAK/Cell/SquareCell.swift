//
//  SquareCell.swift
//  TestovoeAK
//
//  Created by MacBook Air on 13.03.2024.
//

import UIKit
import Combine

final class SquareCell: UICollectionViewCell {
  
  let timer =  Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  private var cancellables = Set<AnyCancellable>()
  var numbers: [Int] = []

    private var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellLabel)
        backgroundColor = .green
        layer.borderWidth = 0.8
        layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            cellLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.widthAnchor.constraint(equalToConstant: 20),
            cellLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
   func configureCellText(with randomNumber: Int) {
     cellLabel.text = String(randomNumber)
  }

    override var isHighlighted: Bool {
           didSet {
               if isHighlighted {
                   UIView.animate(withDuration: 0.2,
                                  delay: 0,
                                  options: .curveEaseOut,
                                  animations: {
                       self.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
                   },
                                  completion: nil)
               } else {
                   UIView.animate(withDuration: 0.2,
                                  delay: 0,
                                  options: .curveEaseOut,
                                  animations: {
                       self.transform = CGAffineTransform(scaleX: 1, y: 1)
                   },
                                  completion: nil)
               }
           }
       }
  
  func updateLabelText()  {
    timer
      .sink { [weak self] _ in
        guard let self else { return }
        let newValue = Int.random(in: 0...50)
        cellLabel.text = String(newValue)
      }
      .store(in: &cancellables)
  }
}

