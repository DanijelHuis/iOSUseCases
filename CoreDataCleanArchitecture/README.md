Simple demo project showing usage of CoreData in clean architecture. Instead of using CoreData specific in view and view model, whole logic is on one place (data source).

Pros:
- only one component (data source) deals with CoreData. This makes app flexible and future-proof, replacing CoreData with Realm would be easy, we would only need to change data source.
- we can dedicate people/teams to work on CoreData, rest of the developers don't need to know it.
- moving over to Kotlin multiplatform would be much easier.
- codebase stays decoupled.

Cons:
- not so easy to setup (more components) than using it directly inside views.
- we are missing on some CoreData features (fetched results, snapshots etc.). 
- performance overhead.
