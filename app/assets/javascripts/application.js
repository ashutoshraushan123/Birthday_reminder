// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require ckeditor/init
//= require twitter/bootstrap
//= require bootstrap
//= require_tree .

FILEFIELD = {}
 $(document).ready(function()
 {

 $('.files').change(function() {
    FILEFIELD = $(this)
    var target_id = $(this).val();
    var p=$(FILEFIELD).attr('value');
    var pic = $(FILEFIELD).val()
  
    console.log(pic)    
     console.log(target_id) 

    if((!pic =="" && !pic.match(/(\.bmp|\.png|\.jpg|\.jpeg|\.gif)$/))){

      alert("!Invalid image format,mouseover help option");
     $(FILEFIELD).val("");
      return false;

    }


    else
    {

      var fr = new FileReader;    
      fr.onload = function() {
        var img = new Image;
        img.onload = function() {
            console.log($(FILEFIELD).parent("td").parent("tr").children("td").children(".images"))
            var c=$(FILEFIELD).parent("td").parent("tr").children("td").children(".images")[0];
            var ctx=c.getContext("2d");
            ctx.drawImage(img,0,0,100,100);          
        }
        img.src = fr.result;
                
      };
    
      fr.readAsDataURL(this.files[0]);
     }
    
});


$("#blob_2").popover({ title: 'File fomat :', content: ".jpg , .jpeg , .png , .bmp , .gif", trigger:'hover' });




 $('#1').attr("checked", "checked") && $('#r1').attr("checked","checked") &&
  $("#dump_file").attr("disabled", "disabled") && $('#submit').hide() &&
  $('#new_person :input').removeAttr("disabled") && $("#blob_1").hide() &&
  $("#blob").show() && $("#valid").hide() && $("#valid_1").hide() && $("#valid_2").hide();
  

$("#r2").click(function(){

  $('#new_person :input').attr("disabled", "disabled") && $('.btn').hide()
  $('#submit').show() && $("#dump_file").removeAttr("disabled") &&
  $("#blob_1").show() && $("#blob").hide() && $("#valid").hide() &&
  $("#valid_1").hide() && $("#valid_2").hide();
 
 });

$("#r1").click(function(){

  $('#new_person :input').removeAttr("disabled") && $('.btn').show() &&
  $('#submit').hide() && $("#dump_file").attr("disabled", "disabled") &&
  $("#blob_1").hide() && $("#blob").show() && $("#valid").hide() &&
  $("#valid_1").hide() && $("#valid_2").hide();

 });


$("#button").click(function() {

  var email = $("#person_email").val();
  var img = $("#person_avatar").val();
   
  if (email == null || email == "" || !email.match(/^[a-z0-9_\+-]+(\.[a-z0-9_\+-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.([a-z]{2,4})$/))
 
    {
      $("#valid").show();
      return false;
     
    }
  else if(!img =="" && !img.match(/(\.bmp|\.png|\.jpg|\.jpeg|\.gif)$/))

   {
     
      $("#valid_1").show();
     $("#person_avatar").val("");
      return false; 
    }
  else
    {
      return true;
    }
});


$("#person_avatar").focus(function() {
   $("#valid_1").hide();});
$("#person_email").focus(function() {
  $("#valid").hide();});
$("#dump_file").focus(function() {
  $("#valid_2").hide();});




$("#submit").click(function() {

    var flv = $("#dump_file").val();
       
   if (flv == null || flv == "" || !flv.match(/(\.csv|\.xls|\.xlsv)$/))
    {
      $("#valid_2").show();
      $("#dump_file").val("");
      return false;
    }
  else
    {
      return true;
    }
});


var img ='<img src="/assets/Excel_00.png"/>';

$("#blob_1").popover({ title: 'Format for Excel sheet (.xls / .xlsx)', content: img , trigger:'hover',html: true });

$("#blob").popover({ title: 'File fomat :', content: ".jpg , .jpeg , .png , .bmp , .gif", trigger:'hover' });


$("#valid_3").hide();

$("#dept_submit").click(function() {

    var dept = $("#department_dept").val();
       
   if ( dept == "")
    {
      $("#valid_3").show();
      return false;
    }
  else
    {
      return true;
    }
});

$("#department_dept").focus(function() {
   $("#valid_3").hide();});


 $prev = null
    $('#calendar').fullCalendar({
        dayClick: function(date,allDay,jsEvent,view){
         
          $($prev).css("background","white")
          $prev = $(this)
          $(this).css("background","#3BB9FF")
          newdate = date.toString().split(" ")[2]+"-"+date.toString().split(" ")[1]
          console.log(newdate)
          
          $.ajax({
            url: "people/calendar/"+newdate,
            type: "GET",
            dataType: "html",
            data: newdate,
            success: function(data){
     
              $("#show").html(data)    
            },
             error: function(newdate){
               console.log(newdate)
               $("#show").html("<b>No Birthday Today</b>")
             }
          })
        }
    });


  $("#person_dept").change(function(){

     var dept =$(this).val();
     var team =$("#person_team_name").val();
     $("#person_team_name").html("");
     console.log(dept); 

      $.ajax({
            url: '/people/team_count?dept=' + dept , type: 'get', dataType: 'json',
            processData: false,
            success: function(data) {
               console.log(data);
                if (data == "") {
                   data ="No teams"
                    $("#person_team_name").append( $('<option value="'+""+'">'+"No team"+'</option>'));
                }
                else {
                    // $("#person_team_name").val(data);
                     jQuery.each(data,function(i, v) {
                     $('#person_team_name').append( $('<option value="'+ v[1] +'">'+v[1]+'</option>'));
                     });
                }
            }
        });
   });




 });
