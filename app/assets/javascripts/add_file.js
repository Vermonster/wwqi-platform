$(function(){
  $('.file-upload').on('click', '.fileselectbutton', function(e) {
    var current = $(e.currentTarget).parent().parent().find('#alert-message');
    if (current.children().length > 0)
      current.html("");

    $(e.currentTarget)
      .parent()
      .siblings('.file')
      .find('.upload').trigger('click');
  });
    
  $('.file-upload').on('change', '.upload', function(e) {
    var val = $(this).val();
    var file = val.split(/[\\/]/);
    var current = $(e.currentTarget);
    
    if (!document.documentMode && !$.support.htmlSerialize && !$.support.opactiy) {
      // In case the browser is IE 6 or 7
      var activeFile = new ActiveXObject("Scripting.FileSystemObejct");
      var file_size = activeFile.getFile(val).size;
    } else {
      var file_size = $(this)[0].files[0].size; // Collect the current file size information
    }
    
    file_size = file_size / 1048576;
    if (file_size > 2) {
      current
        .parent()
        .siblings('#alert-message')
        .html("<br /><div class='alert alert-error fade in'><a class='close' data-dismiss='alert'>x</a><span style='font-size: 10pt; font-family: proxima-nova;'>The size of " + file[file.length - 1] + " is over 2MB.</span>");
      current.val("");
    } else {
      current
        .parent()
        .siblings('.dummyfile')
        .find('.filename').val(file[file.length-1]);
    }
  });
});
