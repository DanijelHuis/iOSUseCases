This project is done as proof of concept that we can use iOS 17 @Observable, @Bindable and @Binding to directly access source of truth from view and view models. Our source of truth is stored only on one place and is never copied. 
Note that I am using Binding<T> inside view model, since Binding <T> is UI stuff and very specific, it is not great idea to use it outside of views.

How this works?
- there are two screens - list of notes and note details. List shows list of notes and details screen allows us to edit note's text.
- NoteManager.notes is our source of truth for whole app, we don't copy notes array or individual notes anywhere.
- NoteListViewModel is @Observable, it has listItems computed property that is read by the view. This means that whenever our source of truth changes, view will reflect those changes.
var listItems: [NoteListItem] {
    manageNotesUseCase.notes.map({ .init(id: $0.id, text: $0.text) })
}
- now this is the weird part, NoteDetailsViewModel can mutate note but it doesn't store it, it holds Binding to the note, which means that NoteDetailsViewModel has direct link to source of truth (read and write).

@MainActor @Observable
final class NoteDetailsViewModel {
    var note: Binding<Note>
...

In the view we can directly connect note binding to e.g. TextField
TextField("Text", text: viewModel.note.text)


