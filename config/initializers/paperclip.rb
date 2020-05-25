# if defined?("Paperclip")
#   Paperclip.interpolates :product do |attachment, style|
#     if attachment.instance.class.to_s == "Product"
#       attachment.instance.internal_name
#     else
#       attachment.instance.product.internal_name
#     end
#   end
# end
