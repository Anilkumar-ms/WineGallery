# WineGallery

---
This application contains two tab views
1. Wines list View
2. Favourite view
When a user clicks one any of the above views leads to a detailed view.
---

# Design Principles followed
---
1) Unidirectional data flow
    I am following the Unidirectional data flow in this project. 
    All interaction happens in below unidirectional format
    
    ViewModel->View->EventHandler->ViewModel

2) Domain driven development
    - Creating models based on the actual data coming from the server and logic required for display sits outside domain
    EX:https://medium.com/microtica/the-concept-of-domain-driven-design-explained-3184c0fd7c3f
    
3) Solid Principles
---

# Testability 

---
1) All ViewModel code are completely testable 
---

# Complete project is modular in nature, loosely coupled. Adding, removing, modifying any new feature is very easy. 
---
---
# All files are properly documented by following Apple documentation standards.
---
---
#Improvements
---
1) Fine graining of UI is required.
2) Savings/Retreiving of data through Coredata
3) Minor modularisation like segregating EventHandler from ViewModel
4) Adding placeholder view to AsyncImage
---
