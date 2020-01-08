<?php echo $header; ?>

<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="catalog/view/javascript/cascadingDivs.min.js"></script>
<script>
    jQuery(function () {
        jQuery('#banners').cascadingDivs();
    });
</script>
<style>
                .module.module-info_blocks.module-info_blocks-289 {
    display: none;
}
    .title-divider{
        display: none !important;
    }
    .title-divider-top{
        display: block;
        height: 3px;
        background: #db8fb3;
        margin-top: 15px;
        margin-bottom: 15px;
        margin-left: 36%;
        margin-right: auto;
    }
    .title-divider-bottom{
        display: block;
        height: 3px;
        background: #db8fb3;
        margin-top: 15px;
        margin-bottom: 15px;
        margin-left: auto;
        margin-right: 36%;
    }
    .banner
    {
        background-size: 100% 100% !important;
        width: 690px;
        height: 480px;   
        cursor: pointer;
        box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
    }
@media (max-width: 768px){
.banner
    {
        width: 400px;
        height: 205px;   
        cursor: pointer;
        box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
    }
}
                @media (max-width: 768px) and (min-width:320px){
.banner
    {
        width: 250px;
        height: 280px !importent;   
        cursor: pointer;
        box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
    }
}
    .banner-buttons-row
    {
        margin-top: 400px;
        text-align: center;
        background-color: rgba(0,0,0,.5);
        line-height:2.5;
        color:#fff;
    }
</style>
<div id="banners" class="hidden-xs hidden-sm">
    <?php if (!empty($banner_images)) { ?>
                  <?php foreach ($banner_images as $banner) { ?>        
    <div onclick="window.open('<?php echo $banner['link'] ?>', '_self');" class="banner" style="background: url(<?php echo $banner['image']; ?>) no-repeat;">
        <div class="banner-buttons-row">

        </div>
    </div>
                <?php                
}
}else{ ?>
    <div id="banner-red" class="banner" style="background: url(https://unsplash.it/690/480?image=1053) no-repeat;">
        <div class="banner-buttons-row">

        </div>
    </div>
    <div id="banner-green" class="banner" style="background: url(https://unsplash.it/690/480?image=1052) no-repeat; ">
        <div class="banner-buttons-row">

        </div>
    </div>
    <div id="banner-blue" class="banner" style="background: url(https://unsplash.it/690/480?image=1051) no-repeat;">
        <div class="banner-buttons-row">

        </div>
    </div>


<?php } ?>
                </div>
			
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<?php if ($content_top || $content_bottom || $column_left || $column_right): ?>
<div id="common-home" class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <?php if ($content_top || $content_bottom): ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?><?php echo $content_bottom; ?></div>
    <?php endif; ?>
    <?php echo $column_right; ?></div>
</div>
<?php endif; ?>
<?php echo $j3->loadController('journal3/seo/rich_snippets'); ?>
<?php echo $footer; ?>
