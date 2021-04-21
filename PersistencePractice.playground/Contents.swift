import UIKit



struct Note: Codable {
    let title: String
    let text: String
    let timestamp: Date
}

let note1 = Note(title: "Note One", text: "This is a sample note.", timestamp: Date())
let note2 = Note(title: "Note Two", text: "This is another sample note.", timestamp: Date())
let note3 = Note(title: "Note Three", text: "This is yet another sample note.", timestamp: Date())
let notes = [note1, note2, note3]

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
print(documentDirectory)


let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
print(archiveURL)

let propertyListEncoder = PropertyListEncoder()

// encode and write
let encodedNote = try? propertyListEncoder.encode(notes).write(to: archiveURL, options: .noFileProtection)

// read and decode
let propertyListDecoder = PropertyListDecoder()
if let retrievedNoteData = try? Data(contentsOf: archiveURL) {
    if let decodedNote = try? propertyListDecoder.decode(Array<Note>.self, from: retrievedNoteData){
        for i in 0 ..< decodedNote.count {
            print(decodedNote[i])
        }
    }
}

