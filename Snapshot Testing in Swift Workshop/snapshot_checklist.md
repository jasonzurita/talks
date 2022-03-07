## Snapshot Testing Workshop Checklist

- [ ] Add the [snapshotting library](https://github.com/pointfreeco/swift-snapshot-testing)
- [ ] Location permission screen
  + Snapshot what exists
  + Refactor: Let's add an image
    + Open the newly generated snapshot (when it fails)
    + Update the snapshot
  + Next level: Multiple screen sizes
    + Update the snapshot
- [ ] Date formatting
  + Snapshot what exists
  + Refactor: Full month name
  + Update the snapshot 
- [ ] Summary view
  + Snapshot what exists
  + Refactor: Change which date formatter is used for the header 
    + Update the snapshot
  + Next level: Languages
    + Update view with languages
    + Update the snapshots
- [ ] Integration test
  + Outline of what we want to do
  + Snapshot the root view twice
  + Granting permissions
    + Copy the _notDetermined_ mock into the test to allow for mocking
  + Update the snapshots
- [ ] Defining custom snapshot strategy (isolated-ish example)
  + Define test
  + Copy `.prety(:)` snapshotting strategy
  + Update snapshotting strategy
