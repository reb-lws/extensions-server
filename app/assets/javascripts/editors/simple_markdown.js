document.addEventListener("DOMContentLoaded", function(event) {

  var editor = document.getElementById("editor");
  var preview = document.getElementById("preview");

  window.addEventListener("message", function(event){
    window.noteText = event.data.text || "";
    window.noteId = event.data.id;
    editor.value = window.noteText;
    preview.innerHTML = md.render(window.noteText);
  }, false);

  window.parent.postMessage({status: "ready"}, '*');

  window.md = window.markdownit({
    highlight: function (str, lang) {
       if (lang && hljs.getLanguage(lang)) {
         try {
           return hljs.highlight(lang, str).value;
         } catch (__) {}
       }

       return '';
     }
  }).use(window.markdownitFootnote);


  document.getElementById("editor").addEventListener("input", function(event){
    var text = event.target.value;
    preview.innerHTML = md.render(text);
    if(window.parent != window) {
      window.parent.postMessage({text: text, id: window.noteId}, '*');
    }
  })

  var pressed = false;
  var startWidth = editor.offsetWidth;
  var startX;
  var lastDownX;
  var wrapper = document.getElementById("wrapper");

  var columnResizer = document.getElementById("column-resizer");
  var resizerWidth = columnResizer.offsetWidth;

  var safetyOffset = 15;

  columnResizer.addEventListener("mousedown", function(event){
    pressed = true;
    lastDownX = event.clientX;
    columnResizer.classList.add("dragging");
    editor.classList.add("no-selection");
  })

  document.addEventListener("mousemove", function(event){
    if(!pressed) {
      return;
    }

    var x = event.clientX;
    if(x < resizerWidth/2 + safetyOffset) {
      x = resizerWidth/2 + safetyOffset;
    } else if(x > wrapper.offsetWidth - resizerWidth - safetyOffset) {
      x = wrapper.offsetWidth - resizerWidth - safetyOffset;
    }

    var colLeft = x - resizerWidth/2;
    columnResizer.style.left = colLeft + "px";

    editor.style.width = (colLeft - safetyOffset) + "px";

    removeSelection();

  })

  document.addEventListener("mouseup", function(event){
    if(pressed) {
      pressed = false;
      columnResizer.classList.remove("dragging");
      editor.classList.remove("no-selection");
    }
  })

  function removeSelection() {
    if (window.getSelection) {
      window.getSelection().removeAllRanges();
    } else if (document.selection) {
      document.selection.empty();
    }
  }

























});
