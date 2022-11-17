//
//  ApiManager.swift
//  SpotiFly
//
//  Created by Axel Demorest on 16/11/2022.
//

struct Artist {
    var id: Int
    var name: String
    var picture: String
}

struct Album {
    var id: Int
    var name: String
    var cover: String
}

struct Song {
    var preview: String
    var titleSong: String
    var artistName: String
    var albumCover: String
    var albumName: String
}

import Foundation
import UIKit

class ApiManager {
    
    let baseUrl = "https://api.deezer.com/"
    var album = "album/211985622"
    var artists = [Artist]()

    
    
    
    
    
    
    func fetchTracksFromArtist(searchText: String, completion: @escaping (_ data : [Song], _ error: Error?) -> Void){
        var tracksArray = [Song]()
        let strUrl = "\(baseUrl)search?q=" + searchText
        let url = URL(string: strUrl)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        //print(trueData)
                        for item in trueData! {
                            let preview = item["preview"] as? String
                            let title = item["title"] as? String
                            let artistName = item["artist"]?["name"] as? String
                            let albumImage = item["album"]?["cover"] as? String
                            let albumName = item["album"]?["title"] as? String
                            
                            let song = Song(preview: preview!, titleSong: title!, artistName: artistName!, albumCover: albumImage!, albumName: albumName!)
                            tracksArray.append(song)
                        }
                        completion(tracksArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchArtists(searchText:String ,completion: @escaping (_ data : [Artist], _ error: Error?) -> Void){
        let strUrl = "\(baseUrl)search/artist?q=" + searchText
        let url = URL(string: strUrl)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        //print(trueData)
                        for item in trueData! {
                            let name = item["name"] as? String
                            let id = item["id"] as? Int
                            let picture = item["picture"] as? String

                            
                            let artist = Artist(id: id!, name: name!, picture: picture!)
                            //print(artist)
                            self.artists.append(artist)
                        }
                        completion(self.artists, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchAlbumsFromArtistId(id: Int,completion: @escaping (_ data : [Album], _ error: Error?) -> Void) -> Void {
        
        var albumsArray = [Album]()
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let strUrl = "\(baseUrl)artist/\(id)/albums"
        let url = URL(string: strUrl)!
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        let trueData = data["data"] as? [[String:AnyObject]]
                        for item in trueData! {
                            let id = item["id"] as? Int
                            let title = item["title"] as? String
                            let cover = item["cover"] as? String
                            
                            let myAlbum = Album(id: id!, name: title!, cover: cover!)
                            albumsArray.append(myAlbum)
                        }
                        completion(albumsArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func fetchTracksFromAlbumId(id:Int, completion: @escaping (_ data : [Song], _ error: Error?) -> Void) -> Void {
        var tracksArray = [Song]()
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let strUrl = "\(baseUrl)album/\(id)"
        let url = URL(string: strUrl)!
        
        let task = session.dataTask(with: url) {
            (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "error")
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []){
                    if let data = json as? [String:AnyObject] {
                        if let tracks = data["tracks"] as? [String:AnyObject] {
                            if let tracksData = tracks["data"] as? [[String:AnyObject]]{
                                for item in tracksData {
                                    let preview = item["preview"] as? String
                                    let title = item["title"] as? String
                                    let artistName = item["artist"]?["name"] as? String
                                    let cover = item["album"]?["cover_medium"] as? String
                                    
                                    let song = Song(preview: preview!, titleSong: title!, artistName: artistName!, albumCover: cover!, albumName: data["title"] as! String)
                                    tracksArray.append(song)

                                }
                            }
                        }
        
                        completion(tracksArray, error)
                        
                    }
                }
            }
        }
        task.resume()
    }
}
