This project is done as proof of concept that we can use @Observable, @Bindable and @Binding to directly access source of truth from view and view models. Our source of truth is stored only on one place and is never copied, both list and details screen read and write directly to source of truth. 

IMPORTANT: As I said, this is just a proof of concept, I don't think that using Binding<T> outside of views is a great idea, but it can work. Also currently I just pass Binding to TextField and everything works, but this can also work in unidirectional approach because view model already owns the binding.

How this works?
- there are two screens - list of notes and note details. List shows list of notes and details screen allows us to edit note's text.
- NoteManager.notes is our source of truth for the whole app, we don't copy notes array or individual notes anywhere.
- NoteListViewModel is @Observable, it has listItems computed property that is read by the view. This means that whenever our source of truth changes (NoteManager.notes), our view will reflect those changes. Note that in order for this to work, NoteManager must also be @Observable.
```
var listItems: [NoteListItem] {
    manageNotesUseCase.notes.map({ .init(id: $0.id, text: $0.text) })
}
```
- NoteDetailsViewModel can mutate note but it doesn't copy it or store it, it holds Binding to the note, which means that NoteDetailsViewModel has direct link to source of truth (read and write).

```
@MainActor @Observable
final class NoteDetailsViewModel {
    var note: Binding<Note>
...
```
In the details view we can directly connect note binding to e.g. TextField and this will directly update our source of truth.
```
TextField("Text", text: viewModel.note.text)
```

