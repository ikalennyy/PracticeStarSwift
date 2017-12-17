//
//  Settings.swift

// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

enum StudentsDataSource{
   case Memory,
    Local,
    CloudObject,
    CloudDB
}

class Settings: NSObject, NSCoding{
    
    var isStudent: Bool = false
    var GetDataFromDB = false
    var dataSource: StudentsDataSource = .Memory

    //did we already seed the cloud wiht our serialized object once?
    var serializedObjectSeededOnce = false
    
    var preFillDB = false
    
    
    override init(){
        
        super.init()
        
        let settingRetrieved: Settings = retrieveSettings()
        
        self.isStudent = settingRetrieved.isStudent
        self.serializedObjectSeededOnce = settingRetrieved.serializedObjectSeededOnce
        
    }
    
    required init?(coder: NSCoder) {
        //TODO: FOR MITJA: WHY DOES IT CRASH HERE???
       // self.isStudent = coder.decodeBool(forKey: "isStudent")
        
        self.serializedObjectSeededOnce = coder.decodeBool(forKey: "serializedObjectSeededOnce")
        // do not call super init(coder:) in this case
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        // do not call super in this case
        coder.encode(self.isStudent, forKey: "isStudent")
         coder.encode(self.serializedObjectSeededOnce, forKey: "serializedObjectSeededOnce")
    }
    
    // TODO: FOR MITJA - IS IT THE SAME AS toString() in Java or likes?
    override var description : String {
        return "Is student " + String(self.isStudent)
    }
    
    
    func saveSettings () {
        let lFileManager = FileManager()
        let lDocumentsDirectoryURL = try! lFileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
       
        let aPersonArchivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        
        let myDataFileURL = lDocumentsDirectoryURL.appendingPathComponent("settingsFile.binary")
        
        try? aPersonArchivedData.write(to: myDataFileURL, options: [.atomic])
    }
    
    func retrieveSettings () -> Settings{
        
        let lFileManager = FileManager()
        let lDocumentsDirectoryURL = try! lFileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let myDataFileURL = lDocumentsDirectoryURL.appendingPathComponent("settingsFile.binary")
        
        let filePath = lDocumentsDirectoryURL.appendingPathComponent("settingsFile.binary").path
        if !lFileManager.fileExists(atPath: filePath) {
            self.saveSettings()
        }
        
        // warning! here do error testing to prevent
        //   the app crashing if you try reading from a file that does not exist!
        
        let lSetting = try! Data(contentsOf: myDataFileURL)
        let settingsModel = NSKeyedUnarchiver.unarchiveObject(with: lSetting) as! Settings
        
        return settingsModel
        
    }

}
