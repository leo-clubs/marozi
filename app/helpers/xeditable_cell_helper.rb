module XeditableCellHelper
  def value_cell(opts)
    opts[:value] ||= ''
    content_tag(:td) { edit_link(opts) }
  end

  def name_cell(name: nil)
    content_tag(:td, {width: '15%'}) { name }
  end

  def edit_link(opts)
    safe_opts = opts.dup
    link_to(safe_opts.delete(:value), '#', {id: safe_opts.delete(:field), :'data-field-type' => safe_opts.delete(:type), :'data-field-value' => safe_opts.delete(:selected), :'data-field-title' => safe_opts.delete(:caption), class: safe_opts.delete(:editable_class)}.merge(safe_opts))
  end
end