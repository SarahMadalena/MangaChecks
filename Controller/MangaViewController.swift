//
//  MangaViewController.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import UIKit

import SDWebImage

class MangaViewController: UIViewController, UITableViewDataSource {
    
    let mangaTableView = UITableView(frame: .zero, style: .grouped) // view
    
    //chamando a Model
    var mangas: [MangasData] = []
    var mangaFav: [MangasData] = [] //vem do delegate

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mangaTableView)
        
        //faz uma requisição dos mangás para ser passada na minha controller
        API.makeRequest {
            //print da lista de array
            (mangas) in
            self.mangas = mangas
            print(mangas)
            DispatchQueue.main.async {
                self.mangaTableView.reloadData()
            }
        }
    
    mangaTableView.translatesAutoresizingMaskIntoConstraints = false
    mangaTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
    mangaTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    mangaTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    mangaTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    mangaTableView.dataSource = self
    mangaTableView.delegate = self
    
    mangaTableView.register(MangaTableViewCell.self, forCellReuseIdentifier: "mangaCell")
    setUpNavigation()
    
}

//view
func setUpNavigation() {
    navigationItem.title = "Mangás"
    navigationController?.navigationBar.prefersLargeTitles = true
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .black
    coloredAppearance.titleTextAttributes = [
        .foregroundColor: UIColor.white
    ]
    coloredAppearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor.white
    ]
    
    self.navigationController?.navigationBar.standardAppearance = coloredAppearance
    self.navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
    self.navigationController?.navigationBar.compactAppearance = coloredAppearance
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
}
}

//controller
extension MangaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentManga = mangas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTableViewCell
        cell.configure(with: currentManga)
        cell.cellDelegate = self
        return cell
    }
    
    
}


extension MangaViewController: CellDelegate {
    func addManga(with manga: MangasData) {
        self.mangaFav.append(manga)
        print(mangaFav.count)
    }
}
