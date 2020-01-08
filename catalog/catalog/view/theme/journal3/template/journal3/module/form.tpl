<?php $id = $j3->uniqueId('field-'); ?>
<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
      <fieldset>
        <?php foreach ($items as $index => $item): ?>
          <?php if ($item['type'] == 'legend'): ?>
            <legend><?php echo $item['label']; ?></legend>
          <?php endif; ?>

          <?php if ($item['type'] == 'select'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <select name="item[<?php echo $index; ?>]" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($item['items'] as $subitem): ?>
                    <option value="<?php echo $subitem['label']; ?>"><?php echo $subitem['label']; ?></option>
                  <?php endforeach; ?>
                </select>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'radio'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <?php foreach ($item['items'] as $subitem): ?>
                  <div class="radio">
                    <label>
                      <input type="radio" name="item[<?php echo $index; ?>]" value="<?php echo $subitem['label']; ?>"/>
                      <?php echo $subitem['label']; ?></label>
                  </div>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'checkbox'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <?php foreach ($item['items'] as $subitem): ?>
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" name="item[<?php echo $index; ?>][]" value="<?php echo $subitem['label']; ?>"/>
                      <?php echo $subitem['label']; ?></label>
                  </div>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'text' || $item['type'] == 'name'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <input type="text" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'email'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <input type="email" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'tel'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <input type="tel" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'textarea'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <textarea name="item[<?php echo $index; ?>]" rows="5" placeholder="<?php echo $item['label']; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"></textarea>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'file'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <button type="button" id="button-custom-field<?php echo $item['item_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default upload-btn"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                <input type="hidden" name="item[<?php echo $index; ?>]" value="<?php echo $register_item[$item['item_id']]; ?>"/>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'date'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <div class="input-group date" data-picker-class="module-form-<?php echo $module_id; ?>">
                  <input type="text" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" data-date-format="YYYY-MM-DD" data-locale="<?php echo $datepicker; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
                  <div class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </div>
                </div>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'time'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <div class="input-group time" data-picker-class="module-form-<?php echo $module_id; ?>">
                  <input type="text" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" data-date-format="HH:mm" data-locale="<?php echo $datepicker; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
                  <div class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </div>
                </div>
              </div>
            </div>
          <?php endif; ?>

          <?php if ($item['type'] == 'datetime'): ?>
            <div class="form-group custom-field <?php if ($item['required']): ?>required<?php endif; ?>">
              <label class="col-sm-2 control-label" for="<?php echo $id; ?>-<?php echo $index; ?>"><?php echo $item['label']; ?></label>
              <div class="col-sm-10">
                <div class="input-group datetime" data-picker-class="module-form-<?php echo $module_id; ?>">
                  <input type="text" name="item[<?php echo $index; ?>]" value="" placeholder="<?php echo $item['label']; ?>" data-date-format="YYYY-MM-DD HH:mm" data-locale="<?php echo $datepicker; ?>" id="<?php echo $id; ?>-<?php echo $index; ?>" class="form-control"/>
                  <div class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </div>
                </div>
              </div>
            </div>
          <?php endif; ?>
        <?php endforeach; ?>
        <?php if ($captcha): ?>
          <div class="form-group captcha">
            <?php echo $captcha; ?>
          </div>
        <?php endif; ?>
        <?php if ($agree_data): ?>
          <div class="checkbox">
            <label>
              <input type="checkbox" name="agree" value="1"/>
              <?php echo $agree_data['text']; ?>
            </label>
          </div>
        <?php endif; ?>
      </fieldset>
      <div class="buttons">
        <div class="pull-right">
          <button type="submit" class="btn btn-primary" data-loading-text="<span><?php echo $button_submit; ?></span>"><span><?php echo $button_submit; ?></span></button>
        </div>
      </div>
    </form>
  </div>
</div>
