<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-rest_api" data-toggle="tooltip" title="<?php echo $button_save; ?>"
                        class="save-changes btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if ($install_success) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $install_success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <?php echo (empty($rest_api_licensed_on)) ? base64_decode('ICAgIDxkaXYgY2xhc3M9ImFsZXJ0IGFsZXJ0LWRhbmdlciBsaWNlbnNlX2FsZXJ0X2Jsb2NrIj4NCiAgICAgICAgPGJ1dHRvbiB0eXBlPSJidXR0b24iIGNsYXNzPSJjbG9zZSIgZGF0YS1kaXNtaXNzPSJhbGVydCIgYXJpYS1oaWRkZW49InRydWUiPsOXPC9idXR0b24+DQogICAgICAgIDxoND5XYXJuaW5nISBVbmxpY2Vuc2VkIHZlcnNpb24gb2YgdGhlIGV4dGVuc2lvbiE8L2g0Pg0KICAgICAgICA8cD5Zb3UgYXJlIHJ1bm5pbmcgYW4gdW5saWNlbnNlZCB2ZXJzaW9uIG9mIHRoaXMgZXh0ZW5zaW9uISBZb3UgbmVlZCB0byBlbnRlciB5b3VyIG9yZGVyIElEIHRvIGVuc3VyZSBwcm9wZXIgZnVuY3Rpb25pbmcsIGFjY2VzcyB0byBzdXBwb3J0IGFuZCB1cGRhdGVzLjwvcD48ZGl2IHN0eWxlPSJoZWlnaHQ6NXB4OyI+PC9kaXY+DQogICAgPC9kaXY+') : '' ?>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-rest_api"
                      class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select name="rest_api_status" id="input-status" class="form-control restapi_status">
                                <?php if ($rest_api_status) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-entry-key">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_secret_key; ?>">
                <?php echo $entry_key; ?>
              </span>
                        </label>
                        <div class="col-sm-10">
                            <input id="input-key" class="form-control" type="text" name="rest_api_key" value="<?php echo $rest_api_key; ?>"
                                   required="required"/>
                             <br>
                            <button type="button" id="button-generate" class="btn btn-primary"><i class="fa fa-refresh"></i> <?php echo $button_generate_api_key; ?></button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-entry-order-id">
                  <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_order_id; ?>">
                    <?php echo $entry_order_id; ?>
                  </span>
                        </label>
                        <div class="col-sm-10">
                            <?php if (empty($rest_api_licensed_on)): ?>
                            <div class="restAPILicenseError"></div>
                            <div class="restAPILicenseSuccess"></div>
                            <div class="restAPILicenseInfo"></div>
                            <table class="table">
                                <tr>
                                    <td colspan="2" style="border: none;">
                                        <input type="text" class="rest_api_ord_id form-control" placeholder="REST-XXX-XXX" name="rest_api_order_id" id="rest_api_order_id" value="<?php echo !empty($rest_api_order_id) ? $rest_api_order_id : ''?>" required="required" />
                                        <br>
                                        <button type="button" class="btn btn-success activateLicenseButton"><i class="icon-ok"></i> Activate License</button>
                                    </td>
                                </tr>
                            </table>

                            <?php
                                $hostname = (!empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : '' ;
                                $hostname = (strstr($hostname,'http://') === false) ? 'http://'.$hostname: $hostname;
                              ?>
                            <script type="text/javascript">
                                var domain='<?php echo base64_encode($hostname); ?>';
                                var timenow=<?php echo time(); ?>;
                            </script>
                            <script type="text/javascript" src="//license.opencart-api.com/validate.js?v=<?php echo time(); ?>"></script>
                            <?php endif; ?>

                            <?php if (!empty($rest_api_licensed_on)): ?>
                            <input type="hidden" class="rest_api_ord_id form-control" name="rest_api_order_id" id="rest_api_order_id" value="<?php echo !empty($rest_api_order_id) ? $rest_api_order_id : ''?>" required="required" />
                            <input name="nJvNVJoMHcQVIuHk" type="hidden" value="<?php echo $rest_api_licensed_on; ?>" />
                            <table class="table licensedTable">
                                <tr>
                                    <td style="border:none;"><b><?php echo($rest_api_order_id); ?></b>
                                        <span style="text-align:center;background-color:#c0f7a5;display: inline-block;padding: 5px 10px;">VALID LICENSE</span>
                                    </td>
                                </tr>
                            </table>
                            <?php endif; ?>
                        </div>
                    </div>
                </form>
                <div class="alert alert-info">
                    <h4><i class="fa fa-info"></i> Info</h4>
                    <p>Please follow the instructions in install.txt to install REST API extension.</p>
                    <p>If you need help please check out our <a
                                href="https://opencart-api.com/opencart-rest-api-documentations/?utm=simple_shopping"
                                target="_blank" class="alert-link">Documentation</a>
                        - You will find walkthrough <a href="https://opencart-api.com/tutorial/?utm=simple_shopping"
                                                       target="_blank" class="alert-link">videos</a>,
                        <a href="https://opencart-api.com/faqs/?utm=simple_shopping" target="_blank" class="alert-link">FAQs</a>,
                        <a href="https://opencart-api.com/forum/?utm=simple_shopping" target="_blank"
                           class="alert-link">forum</a> and more.
                    </p>
                    <p>
                        You can find working PHP demo scripts <a
                                href="https://opencart-api.com/opencart-rest-api-demo-clients/?utm=simple_shopping"
                                target="_blank" class="alert-link">here</a>.
                    </p>
                    <p>
                        If you have any questions about the extension, please do not hesitate to <a
                                href="https://opencart-api.com/contact/?utm=simple_shopping" target="_blank"
                                class="alert-link">contact us</a>.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
    $('#button-generate').on('click', function() {
        rand = '';

        string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

        for (i = 0; i < 32; i++) {
            rand += string[Math.floor(Math.random() * (string.length - 1))];
        }

        $('#input-key').val(rand);
    });
    //--></script>
<?php echo $footer; ?>
