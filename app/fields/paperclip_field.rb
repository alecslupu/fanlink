require "administrate/field/base"

class PaperclipField < Administrate::Field::Base
  def file?
    data.file?
  end

  def url
    data.url
  end

  def thumbnail
    data.url(:thumbnail)
  end

  def to_s
    data
  end
end
