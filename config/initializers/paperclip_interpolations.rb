Paperclip::interpolates :created do |attachment, style|
  attachment.instance.created_at.to_f
end