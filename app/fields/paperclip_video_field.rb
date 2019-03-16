require "administrate/field/base"

class PaperclipVideoField < Administrate::Field::Base
  def file?
    data.file?
  end

  def url
    data.url
  end

  def to_s
    data
  end
end
