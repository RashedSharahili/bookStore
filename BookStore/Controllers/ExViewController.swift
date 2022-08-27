//
//  ExViewController.swift
//  BookStore
//
//  Created by Rashed Shrahili on 27/01/1444 AH.
//

import UIKit

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBook", for: indexPath) as! BookCell
        
        cell.bookImageView.image = UIImage(named: listOfBook[indexPath.row].bookImage)
        cell.bookTitleLabel.text = listOfBook[indexPath.row].title
        cell.bookPriceLabel.text = "\(listOfBook[indexPath.row].price) ر.س"
        cell.bookAuthorLabel.text = listOfBook[indexPath.row].author
        
        if favoriteBook[indexPath.row] == true {
            
            cell.isBookLikedBtn.imageView?.image = UIImage(systemName: "heart.fill")
            cell.isBookLikedBtn.tintColor = .red
            
        } else {
            
            cell.isBookLikedBtn.imageView?.image = UIImage(systemName: "heart")
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        performSegue(withIdentifier: "bookDetailsSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bookDetailsSegue" {
            
            if let viewVC = segue.destination as? DetailsViewController {
                
                viewVC.bookImage = UIImage(named: listOfBook[index!].bookImage)
                viewVC.bookTitle = listOfBook[index!].title
                viewVC.bookPrice = listOfBook[index!].price
                viewVC.bookAuthor = listOfBook[index!].author
            }
        }
        
    }
    
}

extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        bookDefault = []
        
        if searchText == "" {

            bookDefault = listOfBook

        } else {

            for search in listOfBook {

                if search.title.uppercased().contains(searchText.uppercased()) {

                    bookDefault.append(search)
                }
            }

        }
        
//        if !searchText.isEmpty {
//
//            bookDefault = listOfBook.filter({$0.title.uppercased().contains(searchText.uppercased())})
//        }
        
        bookTableView.reloadData()
    }
    
}
