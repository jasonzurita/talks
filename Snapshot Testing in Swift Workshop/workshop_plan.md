# Snapshot Testing Workshop Outline

Resources
- GivenWhenThen](https://martinfowler.com/bliki/GivenWhenThen.html)
- [SnapshotTesting library](https://github.com/pointfreeco/swift-snapshot-testing)
  + [A Tour of Snapshot Testing](https://www.pointfree.co/episodes/ep41-a-tour-of-snapshot-testing)
- [Snapshot Testing in Swift, DIY](https://www.stephencelis.com/2017/09/snapshot-testing-in-swift)

## Outline
### Wait for everyone to join (5 min)

### Intro (5 min)
- Let everyone know to ask questions & interrupt me at any point. The session should be interactive!

### Ice breaker (10 min)
- Name & hopes from WWDC this year 

### Overview snapshot testing (7 min)
- What is snapshot testing
  + Different types of tests
  + Saving artifacts, regenerating them later, and comparing to make sure they have stayed the same
  + Not just for user interfaces (UI)
  + Checked into the code and show a nice history but also a great history of the changes in the app
  + Great for designers to get involved with PRs or any reviews because they can see the different combinations by inspection of the app’s UI

- Why/when would we want to do it
  + Simple yet powerful
  + On the easier side to maintain
  + Different types of snapshot tests. They aren't just for UI! Snapshotting includes screenshot testing.    
  + Safety net & disposable
  + Totally compatible with CI

### Overview of the starter app (10 min)
- Have everyone build the app
- We are going to add snapshots in different places for different things

### Add the snapshotting library as a dependency (2 min)

### [Snapshot Testing Workshop Checklist](./workshop_plan.md) (~60 min)
- 5 minute break sometime

### Conclusion (10 min)
- Questions
- Pass on Point-Free promo code
  + Good as of 3/24/22
  + Ask for feedback
