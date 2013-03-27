# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 
  $('#collaborators').on('cocoon:after-insert', (e) ->
    console.log('cocoon after-insert triggered')
    test = [ "Alex", "Pendar Yousefi", "Ali Pendarpour", "Jason" ]
    alert("wow")
    $('input[name$="[user_id]"]').autocomplete source: test
  )
  # -# $(function() {
  # -#   $('#collaborators')
  # -#     .on('cocoon:after-insert', function (e, added_collborator) {
  # -#       console.log('hello');
  # -#       var test = [
  # -#        "Alex",
  # -#         "Pendar Yousefi",
  # -#         "Ali pendarpour",
  # -#         "Jason Baguio"
  # -#         ];
  # -#       alert("wow");
  # -#       $('input[name$="[user_id]"]').autocomplete({
  # -#         source: test 
  # -#       });
  # -#   });
  # -#  //$('#collaborators a.add_fields').autocomplete({
  # -#     //  source: availableUsers
  # -#     //});
  # -#   });
