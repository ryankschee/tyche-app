<style>

.theme-config {
    position: absolute;
    top: 90px;
    right: 0;
    overflow: hidden;
}
.theme-config-box {
    margin-right: -220px;
    position: relative;
    z-index: 2000;
    transition-duration: 0.8s;
}
.theme-config-box.show {
    margin-right: 0;
}
.spin-icon {
    background: #1ab394;
    position: absolute;
    padding: 7px 10px 7px 13px;
    border-radius: 20px 0 0 20px;
    font-size: 16px;
    top: 0;
    left: 0;
    width: 40px;
    color: #fff;
    cursor: pointer;
}
.skin-setttings {
    width: 220px;
    margin-left: 40px;
    background: #f3f3f4;
}
.skin-setttings .title {
    background: #efefef;
    text-align: center;
    text-transform: uppercase;
    font-weight: 600;
    display: block;
    padding: 10px 15px;
    font-size: 12px;
}
.setings-item {
    padding: 10px 30px;
}
.setings-item.skin {
    text-align: center;
}
.setings-item .switch {
    float: right;
}
.skin-name a {
    text-transform: uppercase;
}
.setings-item a {
    color: #fff;
}

</style>

<div class="theme-config" style="display:none;">
    <div class="theme-config-box">
        <div class="spin-icon" onclick="sw000_toggleWindow();">
            <i class="fa fa-cogs fa-spin"></i>
        </div>
        <div class="skin-settings">
            <div class="title">Configuration <br>
            <small style="text-transform: none;font-weight: 400">
                Config box designed for demo purpose. All options available via code.
            </small></div>
            <div class="setings-item">
                    <span>
                        Collapse menu
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu">
                        <label class="onoffswitch-label" for="collapsemenu">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="setings-item">
                    <span>
                        Fixed sidebar
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="fixedsidebar" class="onoffswitch-checkbox" id="fixedsidebar">
                        <label class="onoffswitch-label" for="fixedsidebar">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="setings-item">
                    <span>
                        Top navbar
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar">
                        <label class="onoffswitch-label" for="fixednavbar">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="setings-item">
                    <span>
                        Top navbar v.2
                        <br>
                        <small>*Primary layout</small>
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="fixednavbar2" class="onoffswitch-checkbox" id="fixednavbar2">
                        <label class="onoffswitch-label" for="fixednavbar2">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="setings-item">
                    <span>
                        Boxed layout
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout">
                        <label class="onoffswitch-label" for="boxedlayout">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <div class="setings-item">
                    <span>
                        Fixed footer
                    </span>

                <div class="switch">
                    <div class="onoffswitch">
                        <input type="checkbox" name="fixedfooter" class="onoffswitch-checkbox" id="fixedfooter">
                        <label class="onoffswitch-label" for="fixedfooter">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="title">Skins</div>
            <div class="setings-item default-skin">
                    <span class="skin-name ">
                         <a href="#" class="s-skin-0">
                             Default
                         </a>
                    </span>
            </div>
            <div class="setings-item blue-skin">
                    <span class="skin-name ">
                        <a href="#" class="s-skin-1">
                            Blue light
                        </a>
                    </span>
            </div>
            <div class="setings-item yellow-skin">
                    <span class="skin-name ">
                        <a href="#" class="s-skin-3">
                            Yellow/Purple
                        </a>
                    </span>
            </div>
            <div class="setings-item ultra-skin">
                    <span class="skin-name ">
                        <a href="md_skin/" class="md-skin">
                            Material Design
                        </a>
                    </span>
            </div>
        </div>
    </div>
</div>

<script>

function sw000_toggleWindow()
{
    $(".theme-config-box").toggleClass("show");
} // .end of sw000_toggleWindow

</script>