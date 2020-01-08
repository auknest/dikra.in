<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); ?>
<?php $grid_center = 12; 
if($column_left != '') $grid_center = $grid_center-3; 
if($column_right != '') $grid_center = $grid_center-3;

require_once( DIR_TEMPLATE.$config->get($config->get('config_theme') . '_directory')."/lib/module.php" );
$modules_old_opencart = new Modules($registry); ?>
<style>
    #overlay{
        position:fixed;
        z-index:99999;
        top:0;
        left:0;
        bottom:0;
        right:0;
        background:#ffffff;
        transition: 1s 0.4s;
    }
    #progress{
        height:1px;
        background:#fff;
        position:absolute;
        width:0;
        top:50%;
    }
    #progstat{
        font-size:0.7em;
        letter-spacing: 3px;
        position:absolute;
        top:50%;
        margin-top:-40px;
        width:100%;
        text-align:center;
        color:#000;
    }
</style>
<script>
    (function () {
                    function id(v){return document.getElementById(v); }
            function loadbar() {
                var ovrl = id("overlay"),
                        // prog = id("progress"),
                        stat = id("progstat"),
                        img = document.images,
                        c = 0;
                tot = img.length;
                function imgLoaded() {
                    c += 1;
                    var perc = ((100 / tot * c) << 0) + "%";
                    // prog.style.width = perc;
                    stat.innerHTML = "<h3>Loading ... </h3>";
                    if (c === tot)
                        return doneLoading();
                }
                function doneLoading() {
                    ovrl.style.opacity = 0;
                    setTimeout(function () {
                        ovrl.style.display = "none";
                    }, 1200);
                }
                for (var i = 0; i < tot; i++) {
                    var tImg = new Image();
                    tImg.onload = imgLoaded;
                    tImg.onerror = imgLoaded;
                    tImg.src = img[i].src;
                }
            }
            document.addEventListener('DOMContentLoaded', loadbar, false);
        }());
</script>
<!-- MAIN CONTENT
        ================================================== -->
<div class="main-content <?php if($theme_options->get( 'content_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'content_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'content_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?> home">
    <div class="background-content"></div>
    <div class="background">
        <div class="shadow"></div>
        <div class="pattern">
            <div class="container">
                <?php 
                $preface_left = $modules_old_opencart->getModules('preface_left');
                $preface_right = $modules_old_opencart->getModules('preface_right');
                ?>
                <?php if( count($preface_left) || count($preface_right) ) { ?>
                <div class="row">
                    <div class="col-sm-8">
                        <?php
                        if( count($preface_left) ) {
                        foreach ($preface_left as $module) {
                        echo $module;
                        }
                        } ?>
                    </div>

                    <div class="col-sm-4">
                        <?php
                        if( count($preface_right) ) {
                        foreach ($preface_right as $module) {
                        echo $module;
                        }
                        } ?>
                    </div>
                </div>
                <?php } ?>

                <?php 
                $preface_fullwidth = $modules_old_opencart->getModules('preface_fullwidth');
                if( count($preface_fullwidth) ) { ?>
                <div class="row">
                    <div class="col-sm-12">
                        <?php
                        foreach ($preface_fullwidth as $module) {
                        echo $module;
                        }
                        ?>
                    </div>
                </div>
                <?php } ?>

                <div class="row">				
                    <?php 
                    $columnleft = $modules_old_opencart->getModules('column_left');
                    if( count($columnleft) ) { ?>
                    <div class="col-md-3" id="column_left">
                        <?php
                        foreach ($columnleft as $module) {
                        echo $module;
                        }
                        ?>
                    </div>
                    <?php } ?>
                    <?php $grid_center = 12; if( count($columnleft) ) { $grid_center = 9; } ?>
                    <div class="col-md-<?php echo $grid_center; ?>">
                        <?php 
                        $content_big_column = $modules_old_opencart->getModules('content_big_column');
                        if( count($content_big_column) ) { 
                        foreach ($content_big_column as $module) {
                        echo $module;
                        }
                        } ?>

                        <div class="row">
                            <?php 
                            $grid_content_top = 12; 
                            $grid_content_right = 3;
                            $column_right = $modules_old_opencart->getModules('column_right'); 
                            if( count($column_right) ) {
                            if($grid_center == 9) {
                            $grid_content_top = 8;
                            $grid_content_right = 4;
                            } else {
                            $grid_content_top = 9;
                            $grid_content_right = 3;
                            }
                            }
                            ?>
                            <div class="col-md-<?php echo $grid_content_top; ?>">
                                <?php 
                                $content_top = $modules_old_opencart->getModules('content_top');
                                if( count($content_top) ) { 
                                foreach ($content_top as $module) {
                                echo $module;
                                }
                                } ?>
                            </div>

                            <?php if( count($column_right) ) { ?> 
                            <div class="col-md-<?php echo $grid_content_right; ?>">
                                <?php foreach ($column_right as $module) {
                                echo $module;
                                } ?>
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>

                <div class="row">	
                    <div class="col-sm-12">	
                        <?php 
                        $contentbottom = $modules_old_opencart->getModules('content_bottom');
                        if( count($contentbottom) ) { ?>
                        <?php
                        foreach ($contentbottom as $module) {
                        echo $module;
                        }
                        ?>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>