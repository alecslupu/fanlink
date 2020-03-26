class ChangingAttributesValidator < ActiveModel::Validator
  # it's checking if the record is being published and other attributes are also being updated
  # at the same time
  # or if just the status is being updated (publishing or unpublishing)
  # in the second condition of the OR operation it's also added that if
  # the changes size is 0, then it should not raise a validation error because
  # you can press update without actually changing anything

  def validate(record)
    record.errors.add(
      :status,
      "is the only attribute that can be changed when the record is published or being published"
    ) if record.changes.size > 1 || (record.changes["status"].blank? && record.changes.size == 1)
  end
end
