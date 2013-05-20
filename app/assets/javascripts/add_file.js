$(function(){
  $('.file-upload').on('click', '.fileselectbutton', function(e) {
    $(e.currentTarget)
      .parent()
      .siblings('.file')
      .find('.upload').trigger('click');
  });
    
  $('.file-upload').on('change', '.upload', function(e) {
    var val = $(this).val();
    
    var file = val.split(/[\\/]/);

    var current = $(e.currentTarget);
    current
      .parent()
      .siblings('.dummyfile')
      .find('.filename').val(file[file.length-1]);
  });
});
