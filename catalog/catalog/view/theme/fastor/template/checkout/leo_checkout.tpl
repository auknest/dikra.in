<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<div id="quick-checkout">
    <style>
        .check_out_loading {
            position: fixed;
            height: 100%;
            width: 100%;
            top:0;
            left: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index:9999;
            font-size: 20px;
            text-align: center;
            padding-top: 200px;
            color: #fff;
        }
    </style>
    <div class="check_out_loading" id="loader" style="display: none">

        <br /><p>Please wait while  processing your request</p>
    </div>
    <div class="row" >

        <div id="cart_info" >
        </div>

    </div>

    <div class="row">
        <div class="col-md-8">

            <div id="payment_address" class="col-sm-12">

            </div>
        </div>
        <div class="col-md-4">
            <div id="typeaccount" class="col-sm-12">

            </div>

            <?php /*<div id="shipping_method" class="col-sm-12">


            </div> */ ?>
            <div id="payment_method" class="col-sm-12">

            </div>
            <div class="col-sm-12">
                <div id="tmd_confirmation">

                </div> 
            </div>


        </div>
    </div>

</div>
<!-- Leo CheckOut -->
<script type="text/javascript"><!--



//--></script>

<script>
    var shipping_required = '1';
    var button_order = 'Order';
    var button_shopping = 'Continue Shopping';
    var text_loading = 'Loading...';
    var quicklogged = '24';
    var checkoutterms_id = '1';
    var errorcart = '';
    var continuebtnstatus = '1';
    var commenterror = 'Please Add comment here';
    var agreeerror = 'Warning: You must agree to the Privacy Policy!';
    var commentvalidation = '';
    var order_error = false;
    function confirm_order() {
        $.ajax({
            url: 'index.php?route=checkout/leo_confirm',
            dataType: 'html',
            complete: function () {
                $('#button-payment-method').button('reset');
            },
            success: function (html) {
                $('#tmd_confirmation').html(html);
                $('#button-confirm').trigger('click')
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
    /* load cart */
    loadcart();
    function payment_address() {
        $.ajax({
            url: 'index.php?route=checkout/leo_payment_address',
            dataType: 'html',
            success: function (html) {

                $('#payment_address').html(html);
                payment_method();
            }
        });
    }

    function shipping_method() {
        $.ajax({
            url: 'index.php?route=checkout/leo_shipping_method',
            dataType: 'html',
            success: function (html) {
                // Add the shipping address
//                shipping_address();
                $('#shipping_method').html(html);
                loadcart();
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function payment_method() {
        $.ajax({
            url: 'index.php?route=checkout/leo_payment_method',
            dataType: 'html',
            success: function (html) {
                $('#payment_method').html(html);
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
    function loadcart(){
    $.ajax({
    url: 'index.php?route=checkout/leo_checkout/cart',
            dataType: 'html',
            success: function(html) {
            $('#cart_info').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    }
    <?php if (!$logged) { ?>
            $(document).ready(function() {
    $.ajax({
    url: 'index.php?route=checkout/leo_login',
            dataType: 'html',
            success: function(html) {
            $('#typeaccount').html(html);
                    $.ajax({
                    url: 'index.php?route=checkout/leo_' + $('input[name=\'account\']:checked').val(),
                            dataType: 'html',
                            beforeSend: function() {
                            $('#button-account').button('loading');
                            },
                            complete: function() {
                            $('#button-account').button('reset');
                            },
                            success: function(html) {
                            $('.alert, .text-danger').remove();
                                    $('#payment_address').html(html);
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                    });
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    });
            <?php } else { ?>
            $("#loader").show();
            loadfinalbtn();
            $.ajax({
            url: 'index.php?route=checkout/leo_payment_address',
                    dataType: 'html',
                    success: function (html) {
                    $('#payment_address').html(html);
                            payment_method();
                            shipping_method();
                            $("#loader").hide();
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
            });
            <?php } ?>
            function register() {
            $.ajax({
            url: 'index.php?route=checkout/leo_register/save',
                    type: 'post',
                    data: $('#payment_address input[type=\'text\'], #payment_address input[type=\'date\'], #payment_address input[type=\'datetime-local\'], #payment_address input[type=\'time\'], #payment_address input[type=\'password\'], #payment_address input[type=\'hidden\'], #payment_address input[type=\'checkbox\']:checked, #payment_address input[type=\'radio\']:checked, #payment_address textarea, #payment_address select'),
                    dataType: 'json',
                    beforeSend: function() {
                    $('#button-confirm').button('loading');
                    },
                    complete: function() {
                    $('#button-confirm').button('reset');
                    },
                    success: function(json) {
                    $('.alert, .text-danger').remove();
                            $('.form-group').removeClass('has-error');
                            if (json['redirect']) {
                    location = json['redirect'];
                    } else if (json['error']) {
                    $('#button-confirm').button('reset');
                            if (json['error']['warning']) {

                    $('#payment_address ').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }

                    for (i in json['error']) {

                    var element = $('#input-payment-' + i.replace('_', '-'));
                            if ($(element).parent().hasClass('input-group')) {
                    $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                    } else {
                    $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                    }

                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                            return false;
                    } else {
                    location.reload();
                    }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
            });
            }
    function payment_address_save(){
    $.ajax({
    url: 'index.php?route=checkout/leo_payment_address/save',
            type: 'post',
            data: $('#payment_address input[type=\'text\'], #payment_address input[type=\'date\'], #payment_address input[type=\'datetime-local\'], #payment_address input[type=\'time\'], #payment_address input[type=\'password\'], #payment_address input[type=\'checkbox\']:checked, #payment_address input[type=\'radio\']:checked, #payment_address input[type=\'hidden\'], #payment_address textarea, #payment_address select'),
            dataType: 'json',
            beforeSend: function() {
            $('#button-confirm').button('loading');
            },
            complete: function() {
            $('#button-confirm').button('reset');
            },
            success: function(json) {
            $('.alert, .text-danger').remove();
                    if (json['redirect']) {
            location = json['redirect'];
            } else if (json['error']) {
            order_error = true;
                    if (json['error']['warning']) {

            $('#payment_address').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            for (i in json['error']) {
            var element = $('#input-payment-' + i.replace('_', '-'));
                    if ($(element).parent().hasClass('input-group')) {
            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
            } else {
            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
            }
            order_error = true;
            }

            // Highlight any found errors
            $('.text-danger').parent().parent().addClass('has-error');
            } else {
            }
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    }
    $(document).delegate('#payment_method input[type="radio"]', 'click', function(){
    save_payment_method();
    });
            function  save_payment_method(){
            $.ajax({
            url: 'index.php?route=checkout/leo_payment_method/save',
                    type: 'post',
                    data: $('#payment_method input[type=\'radio\']:checked, #payment_method input[type=\'checkbox\']:checked, #payment_method textarea'),
                    dataType: 'json',
                    beforeSend: function() {
                    $('#button-confirm').button('loading');
                    },
                    complete: function() {
                    $('#button-confirm').button('reset');
                    },
                    success: function(json){
                    $('#warning .alert, #warning .text-danger').remove();
                            if (json['redirect']) {
                    console.log(json['redirect'])
                            // location = json['redirect'];
                    } else if (json['error']) {
                    if (json['error']['warning']) {
                    $('#payment_method ').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }
                    return false;
                    } else{
                    loadfinalbtn();
                    }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
            });
            }

    function shipping_method_save() {
    $.ajax({
    url: 'index.php?route=checkout/leo_shipping_method/save',
            type: 'post',
            data: $('#shipping_method input[type=\'radio\']:checked, #shipping_method textarea'),
            dataType: 'json',
            beforeSend: function() {
            $('#button-confirm').button('loading');
            },
            complete: function() {
            $('#button-confirm').button('reset');
            },
            success: function(json) {
            loadcart();
                    $('.alert, .text-danger').remove();
                    if (json['redirect']) {
            location = json['redirect'];
            } else if (json['error']) {
            $('#button-confirm').button('reset');
                    if (json['error']['warning']) {
            $('#shipping_method .panel-body').prepend('<div class="alert alert-danger">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }
            } else {
            save_payment_method();
            }
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    }

    function loadfinalbtn(){
    if (!errorcart){
    var html = '<div id="final-button">';
            html += '<div class="buttons col-sm-12">';
            html += '<div class="pull-right">';
            html += '<input type="button" value="' + button_order + '" id="button-confirm" class="btn btn-primary" data-loading-text="' + text_loading + '" />';
            html += '</div>';
            html += '</div>';
            html += '</div>';
            $('#tmd_confirmation').html(html);
    }
    }
    $(document).delegate('#button-confirm', 'click', function() {
    if (checkoutterms_id){
    if ($('input[name="agree"]').prop("checked") == false){
    $('#payment_method').after('<div class="col-sm-12"><div class="alert alert-warning checkoutterms">' + agreeerror + '<button type="button" class="close" data-dismiss="alert">&times;</button></div></div>');
            return false;
    }
    }
    order_loger();
    });
            function order_loger(){
            $("#loader").show();
                    $.ajax({
                    url: 'index.php?route=checkout/leo_payment_address/save',
                            type: 'post',
                            data: $('#payment_address input[type=\'text\'], #payment_address input[type=\'date\'], #payment_address input[type=\'datetime-local\'], #payment_address input[type=\'time\'], #payment_address input[type=\'password\'], #payment_address input[type=\'checkbox\']:checked, #payment_address input[type=\'radio\']:checked, #payment_address input[type=\'hidden\'], #payment_address textarea, #payment_address select'),
                            dataType: 'json',
                            beforeSend: function() {
                            $('#button-confirm').button('loading');
                            },
                            complete: function() {
                            $('#button-confirm').button('reset');
                            },
                            success: function(json) {
                            $('.alert, .text-danger').remove();
                                    if (json['redirect']) {
                            location = json['redirect'];
                            } else if (json['error']) {
                            order_error = true;
                                    if (json['error']['warning']) {

                            $('#payment_address').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                            }

                            for (i in json['error']) {
                            var element = $('#input-payment-' + i.replace('_', '-'));
                                    if ($(element).parent().hasClass('input-group')) {
                            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                            } else {
                            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                            }

                            }

                            // Highlight any found errors
                            $('.text-danger').parent().parent().addClass('has-error');
                                    $("#loader").hide();
                                    return false;
                            } else {
                            payment_address()
                                    $.ajax({
                                    url: 'index.php?route=checkout/leo_payment_method/save',
                                            type: 'post',
                                            data: $('#payment_method input[type=\'radio\']:checked, #payment_method input[type=\'checkbox\']:checked, #payment_method textarea'),
                                            dataType: 'json',
                                            beforeSend: function() {
                                            $('#button-confirm').button('loading');
                                            },
                                            complete: function() {
                                            $('#button-confirm').button('reset');
                                            },
                                            success: function(json){
                                            $('#warning .alert, #warning .text-danger').remove();
                                                    if (json['redirect']) {
                                            location = json['redirect'];
                                            } else if (json['error']) {
                                            if (json['error']['warning']) {
                                            $('#payment_method ').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                                            }
                                            $("#loader").hide();
                                                    return false;
                                            } else{
                                            $.ajax({
                                            url: 'index.php?route=checkout/leo_confirm',
                                                    dataType: 'html',
                                                    complete: function () {
                                                    $('#button-payment-method').button('reset');
                                                    },
                                                    success: function (html) {
                                                    $('#tmd_confirmation').html(html);
                                                            $('#order-confirm').trigger('click')
                                                    },
                                                    error: function (xhr, ajaxOptions, thrownError) {
                                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                                    }
                                            });
                                            }
                                            },
                                            error: function(xhr, ajaxOptions, thrownError) {
                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                            }
                                    });
                            }
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                    });
            }
//--></script>
<script>
    $('#input-payment-country').on('change', function() {
    $.ajax({
    url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
            $('#payment_addresss select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
            },
            complete: function() {
            $('.fa-spin').remove();
            },
            success: function(json) {
            if (json['postcode_required'] == '1') {
            $('#payment_address input[name=\'postcode\']').parent().parent().addClass('required');
            } else {
            $('#payment_address input[name=\'postcode\']').parent().parent().removeClass('required');
            }

            html = '<option value=""><?php echo $text_select; ?></option>';
                    if (json['zone'] && json['zone'] != '') {
            for (i = 0; i < json['zone'].length; i++) {
            html += '<option value="' + json['zone'][i]['zone_id'] + '"';
                    if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
            html += ' selected="selected"';
            }

            html += '>' + json['zone'][i]['name'] + '</option>';
            }
            } else {
            html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
            }

            $('#payment_address select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    });
            $('#payment_address select[name=\'country_id\']').trigger('change');
            // Login
            $(document).delegate('#button-login', 'click', function() {
    $.ajax({
    url: 'index.php?route=checkout/leo_login/save',
            type: 'post',
            data: $('#leologin :input'),
            dataType: 'json',
            beforeSend: function() {
            $('#button-login').button('loading');
            },
            complete: function() {
            $('#button-login').button('reset');
            },
            success: function(json) {
            $('.alert, .text-danger').remove();
                    $('.form-group').removeClass('has-error');
                    if (json['redirect']) {
            location = json['redirect'];
            } else if (json['error']) {
            $('.modal-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    // Highlight any found errors
                    $('input[name=\'email\']').parent().addClass('has-error');
                    $('input[name=\'password\']').parent().addClass('has-error');
            }
            },
            error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    });
    });

</script>
<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>