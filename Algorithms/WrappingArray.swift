
//start array
let tracks = ["a", "b", "c", "d", "e"]

//what we should get 
["d", "e", "a", "b", "c"]

let selectedTrack = "d"
var playlist = [String]()
var priorTracks = [String]()

for track in tracks {
    if track == selectedTrack || playlist.count > 0 {
        playlist.append(track)
    } else {
        priorTracks.append(track)
    }
}

playlist.append(contentsOf: priorTracks)

let index = tracks.index(where: {return $0 == selectedTrack})
let preffix = tracks.prefix(upTo: index!)
let suffix = tracks.suffix(from: index!)

suffix + preffix
