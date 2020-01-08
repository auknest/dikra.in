<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
<div class="review-list">

    <?php /* <div class="rating">
    <?php echo $review['rating'] ?> <i class="fa fa-star<?php if($review['rating'] >= 1) { echo ' active'; } ?>"></i> 
    <i class="fa fa-star<?php if($review['rating'] >= 1) { echo ' active'; } ?>"></i>
    <i class="fa fa-star<?php if($review['rating'] >= 2) { echo ' active'; } ?>"></i>
    <i class="fa fa-star<?php if($review['rating'] >= 3) { echo ' active'; } ?>"></i>
    <i class="fa fa-star<?php if($review['rating'] >= 4) { echo ' active'; } ?>"></i>
    <i class="fa fa-star<?php if($review['rating'] >= 5) { echo ' active'; } ?>"></i> 
</div> */ ?>
<div class="text-bold"><span class="rating pull-left" >  <?php echo $review['rating'] ?> <i class="fa fa-star<?php if($review['rating'] >= 1) { echo ' active'; } ?>"></i></span>  <?php echo $review['text']; ?></div>
<div class="review-img">
    <?php if(file_exists('image/reviews/'.$review['image'])&&$review['image']){ ?>
    <br>
    <img height="200" width="200" src="<?php echo 'image/reviews/'.$review['image'] ?>"><br>
    <?php } ?>
</div>
<div class="author text-right" ><i class="fa fa-user"></i>&nbsp;<b><?php echo $review['author']; ?></b> <span><?php echo $review['date_added']; ?></span></div>
<hr>
</div>

<?php } ?>
<div class="row pagination-results">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } else { ?>
<p style="padding-bottom: 10px"><?php echo $text_no_reviews; ?></p>
<?php } ?>
