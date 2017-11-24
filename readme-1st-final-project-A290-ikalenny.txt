
NOTE: I initially had this project inside the “assignments” directory under “pafinalikalenny” directory before moving it to the “final1st” directory.  So, I created that directory before the deadline.


Name:  Igor Kalennyy
Email: ikalenny@iu.edu
Project’s app name: “Practice Progress”


IMPORTANT:  this is NOT a complete program and the information on the screen does not fully represent the 100% correct state of the screen data. For all of the screens, please refer to the .pdf file I provided in the previous assignment.

This program is supposed to be a practice log for the student to mark their practice activity, for the student to get awards,
for the teacher to verify their practice and for the parents to see the progress / issues with the practice quality being rejected by the teacher.

What you see if the “Student” path to see the current and past assignments and to mark the items to practice.
By switching the isStudent flag (see below) you see the teacher’s path.

THIS IS NOT A COMPLETE IMPLEMENTATION.  THE REST OF THE IMPLEMENTATION IS LEFT FOR THE NEXT 8-WEEK SPAN.

———————————————————————————————What I have NOT completed:——————————
I have not completed the “data entry” page where a teacher inputs the new assignment’s tasks. This seemed to be the very page that would take significant and the most amount of time because it would have to accommodate dynamically “on the fly” generated controls and also would have to have grouping of the controls.  This would be the most complicated page in the program.  Therefore, I chose to show the ‘display’ pages to show the ‘flow’ of the program.


———————————————————————————————————DATA———————————————————————————————————

ALL OF THE DATA is mocked by code inside Factory.swift file.  This file creates the data, mocks the state of the objects and then this data is passed to the global object.


———————————————————————————————————SETTINGS PERSISTENCE———————————————————————————————————

The program is saving the settings data into the text file. In the case of this program, it is represented by the object from the class  “Setting” which is saving the option of “IsStudent”.  What it means is that if the user indicated they are a student, they see one set of tabs, and if they are a teacher, they see an additional tab.


———————————————————————————————————KNOWN ISSUES———————————————————————————————————
1. When serializing the “Settings” object, the application crashes.  I do not know why as I am not familiar too much with how encode / decode methods work.  Therefore, the Slider on the Settings page will not save the correct state of the settings.  ALL OF THE CODE for this functionality exists but, since it crashes, I had to comment one line inside the Init() of the SETTINGS.SWIFT file.

THIS LINE THAT CRASHES IS:  self.isStudent = coder.decodeObject(forKey: "isStudent") as! Bool

—————————————READ——————————————————————HOW TO TEST THIS!!!! 
To remediate the problem temporarily, I have hardcoded this value inside the NAVIGATIONCONTROLLER.SWIFT viewDidLoad() method:
theModel?.setting.isStudent = true.

USE THIS LINE to set the value to “true” of “false” to see the effects when re-running the app.  



———————————————————————————————————PARTS I ADDED———————————————————————————————————
There is a separate Test project attached to the solution.  I used it initially to test out my model and the interactions with the model.



