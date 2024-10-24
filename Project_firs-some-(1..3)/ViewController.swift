//
//  ViewController.swift
//  Project_firs-some-(1..3)
//
//  Created by Serhii Prysiazhnyi on 23.10.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установите шрифт для большого заголовка
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)] // Размер шрифта для большого заголовка
        title = "Диви які гарні флажки"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        // Добавляем кнопку "Назад" слева
        let backButton = UIBarButtonItem(title:"\u{274C}", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        setupRecommendButton()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        
        for item in items {
            if item.hasSuffix("3x.png") {
                //                let trimmedName = item.replacingOccurrences(of: "@3x.png", with: "")
                //                let uppercasedName = trimmedName.uppercased()
                //                pictures.append(uppercasedName)
                pictures.append(item)
                pictures.sort()
                print(pictures)
            }
        }
    }
    
    func setupRecommendButton() {
        // Создание кнопки "Рекомендовать приложение"
        let recommendButton = UIBarButtonItem(title: "\u{1F31F}", style: .plain, target: self, action: #selector(recommendTapped))
        navigationItem.rightBarButtonItem = recommendButton
    }
    
    @objc func recommendTapped() {
        let appURL = URL(string: "https://github.com/Prysiazhnyi?tab=repositories")!
        let shareText = "https://github.com/Prysiazhnyi?tab=repositories"
        
        let itemsToShare = [shareText, appURL] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Настройка для iPad
        present(activityVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        // Убираем суффикс и преобразуем в верхний регистр для отображения
        let pictureName = pictures[indexPath.row]
        let trimmedName = pictureName.replacingOccurrences(of: "@3x.png", with: "")
        let uppercasedName = trimmedName.uppercased()
        
        cell.textLabel?.text = uppercasedName
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    // Действие при нажатии на кнопку "Назад"
    @objc func backButtonTapped() {
        // Переводим приложение в фоновый режим
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}

