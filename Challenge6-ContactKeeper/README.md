# 100DaysOfSwiftUI

## Challenge 6: Day 77 Contact Keeper
Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a `List`, and tapping an item in the list should show a detail screen with a larger version of the picture.

Breaking it down, you should:

- Wrap `UIImagePickerController` so it can be used to select photos.
- Detect when a new photo is imported, and immediately ask the user to name the photo.
- Save that name and photo somewhere safe.
- Show all names and photos in a list, sorted by name.
- Create a detail screen that shows a picture full size.
- Decide on a way to save all this data.

Using CoreData to store the contact information. Store images in the document directory referenced by a `UUID` used as the image name.

## Additional Day 78
Your boss has come in and demanded a new feature: when you’re viewing a picture that was imported, you should show a map with a pin on that marked where they were when that pin was added.
