<!-- MODAL WINDOW: Upload Image -->
<div class="modal inmodal" id="segment03_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-xl">
    	<div class="modal-content animated fadeIn">
			<div class="modal-header">
				<span class="modal-title">UPLOAD IMAGES</span>
				<span class="pull-right">
					<button type="button" class="btn btn-xs btn-danger" data-dismiss="modal">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
				</span>
			</div>
            <div class="modal-body">
               	<div class="wrapper wrapper-content">
     				<div class="row">
         				<div class="col-lg-12">
             				<div class="ibox float-e-margins" style="height:100%;">
              					<div class="ibox-title">
                  					<h5>
                  						Upload Title
                  					</h5>												                        
              					</div>
              					<div class="ibox-content">
				                    <form id="imageUploadDropzone" class="dropzone" enctype="multipart/form-data" action="#">
				                        <input id="paramSessionId" name="paramSessionId" type="hidden" value=""/>
				                        <input id="paramPlaceId" name="paramPlaceId" type="hidden" value=""/>
				                        <input id="paramInventoryItemId" name="paramInventoryItemId" type="hidden" value=""/>
				                        <input id="paramImageWidth" name="paramImageWidth" type="hidden" value=""/>
				                        <input id="paramImageHeight" name="paramImageHeight" type="hidden" value=""/>
				                        <div class="dropzone-previews"></div>
				                        <button type="submit" class="btn btn-primary pull-right">
				                        	Upload Now
				                        </button>												                            
				                    </form>
              					</div>
          					</div>
         				</div>											                
     				</div>
			        <div class="row">
			        	<div class="col-lg-12 animated fadeInRight">
			            	<div id="place-cover-photo">
			                </div>
			            </div>
			        </div>
			     </div>	
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                	<i class="fa fa-times" aria-hidden="true"></i> Close
                </button>
                <button type="button" class="btn btn-primary">
                	<i class="fa fa-floppy-o" aria-hidden="true"></i> Save Now
                </button>
            </div>
        </div>
    </div>
</div>		

<script>

// Local variable declaration
var segment03_mw001_widthArray = [];
var segment03_mw001_heightArray = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function segment03_mw001_isOpen()
{
	return ($("#segment03_mw001").data('bs.modal') || {}).isShown;	
} // .end of segment03_mw001_isOpen

function segment03_mw001_init()
{
	// Dropzone --------------------------------------------------------
	Dropzone.options.imageUploadDropzone = {

		url: tycheesCommon_getRemoteServerURL() + '/uploadItemImage',
        autoProcessQueue: false,
        uploadMultiple: true,
        parallelUploads: 10,
        maxFiles: 10,
        addRemoveLinks : true,
        thumbnailWidth: "300",
        thumbnailHeight: "300",

        // Dropzone settings
        init: function() {
            var myDropzone = this;

            this.element.querySelector("button[type=submit]").addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                myDropzone.processQueue();                        
            });
            this.on("sendingmultiple", function() {      
            	console.log("sendingmultiple");
            	            	
            	var sessionId = tycheesCommon_getCurrentSessionId();
            	var itemId = $('#segment03_itemId').val();
            	
            	console.log("Upload File: sessionId="+sessionId);
            	
                $("#paramSessionId").val(sessionId);
				$("#paramPlaceId").val(tycheesCommon_getCurrentPlaceId());  
				$("#paramInventoryItemId").val( itemId );  
				$("#paramImageWidth").val(JSON.stringify(segment03_mw001_widthArray));  
				$("#paramImageHeight").val(JSON.stringify(segment03_mw001_heightArray));
            });
            this.on("successmultiple", function(files, response) {       
            	console.log("successmultiple");                  	
            });
            this.on("errormultiple", function(files, response) {      
            	console.log("errormultiple.files=" + files);
            	console.log("errormultiple.files.length=" + files.length);
            	this.removeFile(files[0]);
            });
         	// customizing the default progress bar
            this.on("uploadprogress", function(file, progress) {

                progress = parseFloat(progress).toFixed(0);

                var progressBar = file.previewElement.getElementsByClassName("dz-upload")[0];
                progressBar.innerHTML = progress + "%";
            });
            this.on("sending", function(file, xhr, formData) {

            	console.log("file.width=" + file.width);
            	console.log("file.height=" + file.height);    

				if (file.width!=null && file.width!=null && file.height!=null && file.height!=null)
				{
                	segment03_mw001_widthArray.push(file.width);
                	segment03_mw001_heightArray.push(file.height);
                }
            });
            this.on("success", function(file, responseText) {
                // Handle the responseText here. For example, add the text to the preview element:
                console.log(document.createTextNode(responseText));
                
                // Obtain returning object (from servlet) in JSON format.
   	 			var returnObj = $.parseJSON(responseText);    	
    	        var returnCode = returnObj.statusCode;
    	        var returnTitle = returnObj.statusTitle;
    	        var returnMessage = returnObj.message;	 				
   					
   				// Remove all files in dropzone
   				this.removeAllFiles();
   				
                if (returnCode=='0')
   				{
   					tycheesLogger_showToast('success','Success', 'Image file uploaded successfully.');
   				
					var imagesList =
						returnObj.imageList;
						
					// Assign to current itemObj
					var itemId = $('#segment03_itemId').val();
   	            	var itemObj = Cached_getItemById( itemId );	
   	            	itemObj.imageList = imagesList;
						
   	            	// Update UI
   	            	segment03_updateUI_images();
   	            	// Hide Modal
   	 				$('#segment03_mw001').modal('hide');
   				}
   				else
   				{
   					// Show error dialog
   		 		    swal({
	                     title: returnTitle,
	                     text: returnMessage + " (" + returnCode + ")",
	                     type: "error",
	                     closeOnConfirm: true
	                }, function () {
   		            	return;
   		            });
   				}
            });
        },
		resize: function(file) {
            var info;

            if (file.width <= file.height) 
            {		            
	            // drawImage(image, srcX, srcY, srcWidth, srcHeight, trgX, trgY, trgWidth, trgHeight) takes an image, clips it to
	            // the rectangle (srcX, srcY, srcWidth, srcHeight), scales it to dimensions (trgWidth, trgHeight), and draws it
	            // on the canvas at coordinates (trgX, trgY).
	            info = {
	                srcX:0,
	                srcY:0,
	                srcWidth: file.width,
	                srcHeight: file.height,
	                trgX:0,
	                trgY:0,
	                trgWidth: parseInt(this.options.thumbnailHeight * file.width / file.height),
	                trgHeight: this.options.thumbnailHeight
	            }
	            console.log("height LONG");
            }
            else 
            {
            	// drawImage(image, srcX, srcY, srcWidth, srcHeight, trgX, trgY, trgWidth, trgHeight) takes an image, clips it to
	            // the rectangle (srcX, srcY, srcWidth, srcHeight), scales it to dimensions (trgWidth, trgHeight), and draws it
	            // on the canvas at coordinates (trgX, trgY).
	            info = {
	                srcX:0,
	                srcY:0,
	                srcWidth: file.width,
	                srcHeight: file.height,
	                trgX:0,
	                trgY:0,
	                trgWidth: this.options.thumbnailWidth,
	                trgHeight: parseInt(this.options.thumbnailWidth * file.height / file.width)
	            }
	            console.log("width LONG");
            }

            return info;
        }
    } // .end of Dropzone
} // .end of segment03_mw001_init

function segment03_mw001_open()
{
    module_showModalWindow('segment03_mw001', true);
} // .end of segment03_mw001_open

</script>