$(function(){
  
  $('.file-upload').on('click', '.fileselectbutton', function(e){
    console.log('hi');
    $('.upload').trigger('click');
  });
    
  $('.file-upload').on('change', '.upload', function(e){
    var val = $(this).val();
    
    var file = val.split(/[\\/]/);

    var current = $(e.currentTarget);
    console.log('whatever');
    debugger;
    current.parent().siblings('.dummyfile').find('.filename').val(file[file.length-1]);
  });

});
