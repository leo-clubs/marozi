module XeditableCellHelper
  def value_cell(opts)
    opts[:value] ||= ''
    content_tag(:td) { edit_link(opts) }
  end

  def name_cell(name: nil, width: '15%')
    content_tag(:td, {width: width}) { name }
  end

  def edit_link(opts)
    safe_opts = opts.dup
    link_to(safe_opts.delete(:value), '#', {id: safe_opts.delete(:field), :'data-field-type' => safe_opts.delete(:type), :'data-field-value' => safe_opts.delete(:selected), :'data-field-title' => safe_opts.delete(:caption), class: safe_opts.delete(:editable_class)}.merge(safe_opts))
  end

  def i18n_date_format_to_xeditable_date_format input_date
    if input_date
      input_date.gsub(/%Y/,'yyyy').gsub(/%m/,'mm').gsub(/%d/,'dd')
    end
  end
end