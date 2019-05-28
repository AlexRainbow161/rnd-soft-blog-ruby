// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-3.4.1
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// File chose monitor
/**
 * @param { string } filename
 */
let cropper = NaN;
function fileNameFromPath(filename){
    const windowsFileSlash = '\\';
    const UnixFileSlash = '/';
    var name = filename;
    if (filename.includes(windowsFileSlash)){
        name = filename.substring(filename.lastIndexOf(windowsFileSlash) + 1);
    }
    else if (filename.includes(UnixFileSlash)){
        name = filename.substring(filename.lastIndexOf(UnixFileSlash) + 1);
    }
    return name;
}
/**
 * 
 * @param { HTMLElement } entity 
 */
function fileInputChangeSingle(pathValue, width="20%", height="20%", needCrop){
    var parentForm = $("#img-preview");
    var label = $('#filename');
    label.html(fileNameFromPath(pathValue.value));
    if(!!$('#preview')){
        $('#preview').remove();
    }
    if (!!$(".cropper-container")){
        $(".cropper-container").remove();
    }
    var filesrc = `<img src=${URL.createObjectURL(pathValue.files[0])} id="preview" class="img-thumbnail" style="width:${width};height:${height}">`;
    parentForm.append(filesrc);
    if(needCrop){
        var img = $('#preview')[0];
        cropper = new Cropper(img, {
            aspectRatio: 1 / 1  
        })
    }
}
function SendCropped(btn){
    $(document).bind('ajaxSend', function(){
        $(btn).attr("disabled", true).text("Сохранение...");
    }).bind("ajaxStop", function(){
        location.reload();
    })
    cropper.getCroppedCanvas().toBlob(function(blob){
        let form  = $("#photo-form");
        let formData = new FormData(form[0]);
        formData.delete("image");
        formData.append("image", blob);
        $.ajax({
            url: form.attr("action"),
            type: "PUT",
            data: formData,
            processData: false,
            contentType: false,
            dataType: "multipart/form-data",
            success: function(){
                console.log(form.attr("action"));
            },
            error: function(err){
                console.log(err);
                console.log(form.attr("action"));
            }

          })
    })
}