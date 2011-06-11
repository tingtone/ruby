Paperclip::Attachment.default_options.merge!(
  :path => ":rails_root/public/uploads/:class/:attachment/:id_partition/:basename_:style.:extension",
  :url => "/uploads/:class/:attachment/:id_partition/:basename_:style.:extension"
)
