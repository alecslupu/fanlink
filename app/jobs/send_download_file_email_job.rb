class SendDownloadFileEmailJob < Struct.new(:person_id, :certcourse_page_id)
  def perform
    PersonMailer.with(id: person_id, certcourse_page_id: certcourse_page_id).send_downloaded_file.deliver_now
  end

  def queue_name
    :default
  end
end
