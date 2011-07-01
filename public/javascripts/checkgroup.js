(function($) {
    $.fn.checkgroup = function(options) {
        settings = $.extend({
            groupSelector:null,
            groupName:'group_name',
            enabledOnly:false,
            onComplete:null,
            onChange:null
        }, options || {});

        var ctrl_box = this;
        var grp_slctr = (settings.groupSelector == null) ? 'input[name=' + settings.groupName + ']' : settings.groupSelector;
        var _onComplete = settings.onComplete;
        var _onChange = settings.onChange;
        _ctrl_box_autoenable = function () {
            if ($(grp_slctr).size() == $(grp_slctr + ':checked').size()) {
                ctrl_box.attr('checked', 'checked');
            }
        }
        _ctrl_box_autodisable = function() {
            ctrl_box.attr('checked', false);
        }

        //grab only enabled checkboxes if required
        if (settings.enabledOnly) {
            grp_slctr += ':enabled';
        }
        //attach click event to the "check all" checkbox(s)
        ctrl_box.click(function(e) {
            var chk_val = (e.target.checked);
            //check the boxes and prepare for callback;
            var boxes = Array();
            var $i = 0;
            $(grp_slctr).each(function() {
                if (this.checked != chk_val) {
                    boxes[$i] = this;
                    this.checked = chk_val;
                    if (typeof _onChange == "function") {
                        _onChange(this);
                    }
                    $i++;
                }
            });
            //if there are other "select all" boxes, sync them
            ctrl_box.attr('checked', chk_val);
            if (typeof _onComplete == "function") {
                _onComplete(boxes);
            }
        });
        //attach click event to checkboxes in the "group"
        $(grp_slctr).click(function() {
            if (!this.checked) {
                _ctrl_box_autodisable();
            }
            else {
                _ctrl_box_autoenable();
            }
        });
        _ctrl_box_autoenable();
        return this;
    };
})(jQuery);