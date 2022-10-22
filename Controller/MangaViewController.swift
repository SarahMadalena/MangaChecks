//
//  MangaViewController.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import UIKit

import SDWebImage

class MangaViewController: UIViewController {
    
    let mangaTableView = UITableView(frame: .zero, style: .grouped) // view
    
    var mangas: [MangasData] = []   //chamando a Model
    
    var mangaFav: [MangasData] = [] //parametro que vem do delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mangaTableView)
        
        let addManga = UIBarButtonItem(title: "Meus Mangás", style: .plain, target: self, action: #selector(playTapped))
        
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
        navigationItem.rightBarButtonItem = addManga
        
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
    
    @objc func playTapped(sender:UIBarButtonItem){
        let vc = SaveMangasViewController()
        vc.mangaFav = mangaFav
        self.show(vc, sender: self)
    }
}

//controller
extension MangaViewController: UITableViewDataSource {
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

extension MangaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MangaViewController: CellDelegate {
    func addManga(with manga: MangasData) {
        self.mangaFav.append(manga)
        print(mangaFav.count)
        //criando entidade
        _ = CoreDataStack.shared.createMangaEntity(mangaData: manga) //singleton
        
        do {
            try CoreDataStack.shared.context.save()
        }
        catch {
            print("não salvou")
        }
        
    }
}
