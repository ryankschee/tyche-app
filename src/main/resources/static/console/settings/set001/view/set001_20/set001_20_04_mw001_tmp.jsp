<!-- MODAL WINDOW: Upload Image -->
<div class="modal inmodal" id="set001_02_04_mw001" tabindex="-1" role="dialog"  aria-hidden="true">
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
				                    <form id="imageUploadDropzone" class="dropzone" enctype="multipart/form-data" method="post" action="http://1-dot-tyche-core-dev.appspot.com/console/uploadImage">
				                        <input id="paramSessionId" name="paramSessionId" type="hidden" value=""/>
				                        <input id="paramPlaceId" name="paramPlaceId" type="hidden" value=""/>
				                        <input id="paramImageSource" name="paramImageSource" type="hidden" value=""/>
				                        <input id="paramImageWidth" name="paramImageWidth" type="hidden" value=""/>
				                        <input id="paramImageHeight" name="paramImageHeight" type="hidden" value=""/>
				                        <div class="dropzone-previews"></div>
				                        <button type="button" class="btn btn-primary pull-right">
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
var set001_20_04_mw001_initialized = false;
var set001_20_04_mw001_widthArray = [];
var set001_20_04_mw001_heightArray = [];

/**
 * Return boolean 'true' if this modal window is open; otherwise 'false'.
 */
function set001_20_04_mw001_isOpen()
{
	return ($("#set001_20_04_mw001").data('bs.modal') || {}).isShown;	
} // .end of set001_20_04_mw001_isOpen

/**
 * Init state.
 */
function set001_20_04_mw001_init()
{
	if (set001_20_04_mw001_initialized)
		return false;

	// Dropzone ----------------------------------------------------------------
	Dropzone.options.dropzone = {

		url: tycheesCommon_getRemoteServerURL() + '/console/uploadImage',
        autoProcessQueue: false,
        autoDiscover: false,
        clickable: false,
        uploadMultiple: true,
        parallelUploads: 10,
        maxFiles: 10,
        addRemoveLinks : true,
        thumbnailWidth: "300",
        thumbnailHeight: "300",

        // Dropzone settings
        accept: function(file, done) {
        	tycheesLogger_logDebug("uploaded", "accept");
            done();
        },
        error: function(file, msg){
        	tycheesLogger_logDebug(msg, "error");
        },
        init: function() {
            var myDropzone = this;
        	tycheesLogger_logDebug("done", "init");   

            this.element.querySelector("button[type=submit]").addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                myDropzone.processQueue();            
            	tycheesLogger_logDebug("processQueue", "button.click");            
            });
            this.on("sendingmultiple", function() {      
            	tycheesLogger_logDebug("sendingmultiple", "sendingmultiple");
            	            	
                $("#paramSessionId").val(tycheesCommon_getCurrentSessionId());
				$("#paramPlaceId").val(tycheesCommon_getCurrentPlaceId());  
				$("#paramImageSource").val(AppConstants.FILE_CONTROL_PLACE_IMAGE);  
				$("#paramImageWidth").val(JSON.stringify(set001_20_04_mw001_widthArray));  
				$("#paramImageHeight").val(JSON.stringify(set001_20_04_mw001_heightArray));
            });
            this.on("successmultiple", function(files, response) {       
            	tycheesLogger_logDebug("successmultiple", "successmultiple");                  	
            });
            this.on("errormultiple", function(files, response) {      
            	tycheesLogger_logDebug("errormultiple.files=" + files, "errormultiple");
            	tycheesLogger_logDebug("errormultiple.files.length=" + files.length, "errormultiple");
            	this.removeFile(files[0]);
            });
         	// customizing the default progress bar
            this.on("uploadprogress", function(file, progress) {

                progress = parseFloat(progress).toFixed(0);

                var progressBar = file.previewElement.getElementsByClassName("dz-upload")[0];
                progressBar.innerHTML = progress + "%";
            });
            this.on("sending", function(file, xhr, formData) {

            	tycheesLogger_logDebug("file.width=" + file.width, "sending");
            	tycheesLogger_logDebug("file.height=" + file.height, "sending");    

				if (file.width!=null && file.width!=null && file.height!=null && file.height!=null)
				{
                	set001_20_04_mw001_widthArray.push(file.width);
                	set001_20_04_mw001_heightArray.push(file.height);
                }
            });
            this.on("success", function(file, responseObj) {
                // Handle the responseObj here. For example, add the text to the preview element:
                tycheesLogger_logDebug(document.createTextNode(responseObj));
                
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
	            tycheesLogger_logDebug("height LONG");
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
	            tycheesLogger_logDebug("width LONG");
            }

            return info;
        }
    } // .end of Dropzone
    
    set001_20_04_mw001_initialized = true;
} // .end of set001_20_04_mw001_init

function set001_20_04_mw001_open()
{
	// Init, if haven't
	set001_20_04_mw001_init();

	// Show Modal Window
    module_showModalWindow('set001_02_04_mw001', true);
} // .end of set001_20_04_mw001_open

</script>